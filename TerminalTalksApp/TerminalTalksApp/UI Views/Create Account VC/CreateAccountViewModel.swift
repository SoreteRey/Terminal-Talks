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
    func createAccount(email: String, password: String, confirmPassword: String) {
        if password == confirmPassword {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error {
                    let alert = UIAlertController(title: "Error Creating Account", message: "It seems that your passwords don't match", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
                        print("User says Okay")
                    }))
                    self.present(alert, animated: true)
                    
                } else if let authResult {
                    let user = authResult.user
                    print(user.uid)
                    print(user.email)
                    
                    //have a pop over to
                }
            }
        }
    }
}
