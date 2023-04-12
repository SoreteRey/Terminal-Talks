//
//  ProfileViewController.swift
//  TerminalTalksApp
//
//  Created by Sebastian Guiscardo on 4/11/23.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
        signOutAlert()
    }

    // MARK: - Functions
    func signOutAlert() {
        let alert = UIAlertController(title: "Sign Out?", message: "Are you sure you want to sign out?", preferredStyle: .alert)
            let dismissAcction = UIAlertAction(title: "Cancel", style: .cancel)
        let confirmAction = UIAlertAction(title: "Sign Out", style: .default) { _ in
            self.signOut()
        }
        alert.addAction(dismissAcction)
        alert.addAction(confirmAction)
        self.present(alert, animated: true)
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            
        }
    }
}
