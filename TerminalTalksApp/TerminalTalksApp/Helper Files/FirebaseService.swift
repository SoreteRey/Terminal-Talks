//
//  FirebaseService.swift
//  TerminalTalksApp
//
//  Created by Sebastian Guiscardo on 4/4/23.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

enum FirebaseError: Error {
    case firebaseError(Error)
    case failedToUnwrapData
    case noDataFound
}

protocol FireBaseSyncable {
    func save(username: String, age: String, aboutYou: String, language: String, nationality: String, image: UIImage, completion: @escaping() -> Void)
    func loadProfile(completion: @escaping (Result<[Profile], FirebaseError>) -> Void)
    func delete(profile: Profile)
    func saveImage(_ image: UIImage, with uuidString: String, completion: @escaping (Result<URL, FirebaseError>) -> Void)
    func fetchImage(from profile: Profile, completion: @escaping (Result<UIImage, FirebaseError>) -> Void)
    func deleteImage(from profile: Profile)
    func update(_ profile: Profile, with newImage: UIImage, completion: @escaping () -> Void)
}

struct FirebaseService: FireBaseSyncable {
    
    // MARK: - Properties
    let ref =  Firestore.firestore()
    let storage = Storage.storage().reference()
    
    
    // MARK: - Functions
    func save(username: String, age: String, aboutYou: String, language: String, nationality: String, image: UIImage, completion: @escaping() -> Void) {
        
        let uuid = UUID().uuidString
        
        saveImage(image, with: uuid) { result in
            switch result {
            case .success(let imageURL):
                let profile = Profile(profileUsername: username, profileAge: age, profileAboutYou: aboutYou, profileLanguage: language, profileNationality: nationality, uuid: uuid, imageURL: imageURL.absoluteString)
                ref.collection(Profile.Key.collectionType).document(profile.uuid).setData(profile.dictionaryRepresentation)
                completion()
            case .failure(let failure):
                print(failure)
                return
            }
        }
    }
    
    func loadProfile(completion: @escaping (Result<[Profile], FirebaseError>) -> Void) {
        ref.collection(Profile.Key.collectionType).getDocuments { snapshot, error in
            if let error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }
            
            guard let docSnapshotArray = snapshot?.documents else {
                completion(.failure(.noDataFound))
                return
            }
            
            let dictionaryArray = docSnapshotArray.compactMap { $0.data() }
            let profile = dictionaryArray.compactMap { Profile(fromDictionary: $0) }
            completion(.success(profile))
            
        }
    }
    
    func delete(profile: Profile) {
        ref.collection(Profile.Key.collectionType).document(profile.uuid).delete()
        deleteImage(from: profile)
        
        
    }
    
    func saveImage(_ image: UIImage, with uuidString: String, completion: @escaping (Result<URL, FirebaseError>) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.05) else { return }
        
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/jpeg"
        
        let uploadTask = storage.child(Constants.Profile.storageImageRef).child(uuidString).putData(imageData, metadata: uploadMetadata) {
            _, error in
            
            if let error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }
        }
        
        uploadTask.observe(.success) { _ in
            print("uploaded image")
            storage.child(Constants.Profile.storageImageRef).child(uuidString).downloadURL { url, error in
                if let error {
                    print(error.localizedDescription)
                    completion(.failure(.firebaseError(error)))
                    return
                }
                
                if let url {
                    print("Image URL: \(url)")
                    completion(.success(url))
                }
            }
        }
        uploadTask.observe(.failure) { snapshot in
            completion(.failure(.firebaseError(snapshot.error!)))
            return
        }
    }
    func fetchImage(from profile: Profile, completion: @escaping (Result<UIImage, FirebaseError>) -> Void) {
        storage.child(Constants.Profile.storageImageRef).child(profile.uuid).getData(maxSize: 1024 * 1024) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completion(.failure(.failedToUnwrapData))
                    return
                }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(.firebaseError(error)))
                return
            }
        }
    }
    
    func deleteImage(from profile: Profile) {
        storage.child(Constants.Profile.storageImageRef).child(profile.uuid).delete(completion: nil)
    }
    
    func update(_ profile: Profile, with newImage: UIImage, completion: @escaping () -> Void) {
        saveImage(newImage, with: profile.uuid) { result in
            switch result {
            case .success(let imageURL):
                profile.imageURL = imageURL.absoluteString
                ref.collection(Profile.Key.collectionType).document(profile.uuid).setData(profile.dictionaryRepresentation)
            case .failure(let failure):
                print(failure)
                return
            }
        }
    }
}
