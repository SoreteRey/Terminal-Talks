//
//  CreateAccountViewModel.swift
//  TerminalTalksApp
//
//  Created by Sebastian Guiscardo on 4/3/23.
//
import FirebaseAuth
import Firebase
import UIKit

struct CreateAccountViewModel {
    
    //Crud
    func createAccount(email: String, password: String, confirmPassword: String, completion: @escaping (Bool, Error?) -> Void) {
        if password == confirmPassword {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error {
                    completion(false, error)
                } else {
                    completion(true, nil)
                }
            }
        }
    }
}
