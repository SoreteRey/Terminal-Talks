//
//  CreateProfileViewModel.swift
//  TerminalTalksApp
//
//  Created by Sebastian Guiscardo on 4/3/23.
//

import UIKit
import FirebaseFirestore

protocol CreateProfileViewModelDelegate: AnyObject {
    func imageSuccessfullySaved()
}

struct CreateProfileViewModel {
    // MARK: - Properties
    var profile: Profile?
    let service: FireBaseSyncable
    private weak var delegate: CreateProfileViewModelDelegate?
    init(profile: Profile? = nil, serviceInjected: FireBaseSyncable = FirebaseService(), delegate: CreateProfileViewModelDelegate) {
        self.profile = profile
        service = serviceInjected
        self.delegate = delegate
    }
    // MARK: - Functions
    func createProfile(username: String, age: String, aboutYou: String, language: String, nationality: String, image: UIImage) {
        if let profile {
            profile.profileUsername = username
            profile.profileAge = age
            profile.profileAboutYou = aboutYou
            profile.profileLanguage = language
            profile.profileNationality = nationality
            service.update(profile, with: image) {
                self.delegate?.imageSuccessfullySaved()
            }
        } else {
            service.save(username: username, age: age, aboutYou: aboutYou, language: language, nationality: nationality, image: image) {
                self.delegate?.imageSuccessfullySaved()
            }
        }
    }
    
    func getImage(completion: @escaping (UIImage?) -> Void) {
        guard let profile = profile else { return }
        service.fetchImage(from: profile) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}

