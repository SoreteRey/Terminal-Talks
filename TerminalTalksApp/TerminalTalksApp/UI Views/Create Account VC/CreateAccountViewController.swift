//
//  CreateAccountViewController.swift
//  TerminalTalksApp
//
//  Created by Sebastian Guiscardo on 4/3/23.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    // MARK: - Properties
    var viewModel: CreateAccountViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CreateAccountViewModel()

        // Do any additional setup after loading the view.
    }
    // MARK: - Actions
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text else { return }
        // present an error for not having any input from the user
        
        viewModel.createAccount(email: email, password: password, confirmPassword: confirmPassword)
    }
}
// MARK: - Option to pop to another view from creating account

//Button(action: goHome) {
//    HStack(alignment: .center) {
//        Spacer()
//        Text("Login").foregroundColor(Color.white).bold()
//        Spacer()
//    }
//}
//
//func goHome() {
//    if let window = UIApplication.shared.windows.first {
//        window.rootViewController = UIHostingController(rootView: HomeScreen())
//        window.makeKeyAndVisible()
//    }
//}
