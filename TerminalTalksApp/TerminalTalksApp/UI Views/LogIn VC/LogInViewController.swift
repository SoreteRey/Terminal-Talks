//
//  LogInViewController.swift
//  TerminalTalksApp
//
//  Created by Sebastian Guiscardo on 4/3/23.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: -
    
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = Auth.auth().currentUser
        let userPhoto = user?.photoURL
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func logInButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, email != "" else { return }
        guard let password = passwordTextField.text, password != "" else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let error {
                print("Error signing in", error.localizedDescription)
                let alert = UIAlertController(title: "Error Logging In", message: "It seems that either your password or email is incorrect", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
                    print("User says Okay")
                }))
                self.present(alert, animated: true)
                }
            
            if let firebaseResult {
                let user = firebaseResult.user
                print(user.uid)
                    
                }
            }
        }
    }

