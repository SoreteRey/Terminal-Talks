//
//  LogInViewController.swift
//  TerminalTalksApp
//
//  Created by Sebastian Guiscardo on 4/3/23.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = Auth.auth().currentUser
        let userPhoto = user?.photoURL
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func logInButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let error {
                //present a uialert to show that password or email was incorrect
                let alert = UIAlertController(title: "Error Logging In", message: "It seems that either your password or email is incorrect", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
                    print("User says Okay")
                }))
                self.present(alert, animated: true)
                } else {
                    //present pop over and show the home screen
                    //go to home screen
                    self.performSegue(withIdentifier: "goToSearch", sender: self)
                }
            }
        }
    }

