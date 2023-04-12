//
//  Profile.swift
//  TerminalTalksApp
//
//  Created by Sebastian Guiscardo on 4/4/23.
//

import Foundation

class Profile {
    
    enum Key {
        static let username =  "username"
        static let age = "age"
        static let aboutYou = "aboutYou"
        static let language = "language"
        static let nationality = "nationality"
        static let uuid = "uuid"
        static let imageURL = "imageURL"
        static let collectionType = "profiles"
    }
    
    // MARK: - Properties
    var profileUsername: String
    var profileAge: String
    var profileAboutYou: String
    var profileLanguage: String
    var profileNationality: String
    var uuid: String
    var imageURL: String?
    //need to make image optional
    // should tell the user that they need to fill in the options
    
    var dictionaryRepresentation: [String: AnyHashable] {
        
        [
            Key.username: self.profileUsername,
            Key.age: self.profileAge,
            Key.aboutYou: self.profileAboutYou,
            Key.language: self.profileLanguage,
            Key.nationality: self.profileNationality,
            Key.uuid: self.uuid,
            Key.imageURL: self.imageURL
        ]
    }
    
    // MARK: - Initializer
    init(profileUsername: String, profileAge: String, profileAboutYou: String, profileLanguage: String, profileNationality: String, uuid: String = UUID().uuidString, imageURL: String) {
        self.profileUsername = profileUsername
        self.profileAge = profileAge
        self.profileAboutYou = profileAboutYou
        self.profileLanguage = profileLanguage
        self.profileNationality = profileNationality
        self.uuid = uuid
        self.imageURL = imageURL
    }
}

extension Profile {
    convenience init?(fromDictionary dictionary: [String : Any]) {
        guard let username = dictionary[Key.username] as? String,
              let age = dictionary[Key.age] as? String,
              let aboutYou = dictionary[Key.aboutYou] as? String,
              let language = dictionary[Key.language] as? String,
              let nationality = dictionary[Key.nationality] as? String,
              let uuid = dictionary[Key.uuid] as? String,
              let imageURL = dictionary[Key.imageURL] as? String else { return nil }
        
        
                
        self.init(profileUsername: username, profileAge: age, profileAboutYou: aboutYou, profileLanguage: language, profileNationality: nationality, uuid: uuid, imageURL: imageURL)
    }
}

extension Profile: Equatable {
    static func == (lhs: Profile, rhs: Profile) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
