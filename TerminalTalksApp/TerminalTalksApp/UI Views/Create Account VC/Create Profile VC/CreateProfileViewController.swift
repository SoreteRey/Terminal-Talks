//
//  CreateProfileViewController.swift
//  TerminalTalksApp
//
//  Created by Sebastian Guiscardo on 4/3/23.
//

import UIKit
import FirebaseDatabase

class CreateProfileViewController: UIViewController {
    
    private let database = Database.database().reference()
   
    // MARK: - Outlets
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var aboutYouTextField: UITextField!
    @IBOutlet weak var languageTextField: UITextField!
    @IBOutlet weak var nationalityTextField: UITextField!
    
    // MARK: - Properties
    var viewModel: CreateProfileViewModel!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = CreateProfileViewModel(delegate: self)
        setUpImageView()
        updateUI()
    }
    
    
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let username = usernameTextField.text,
              let age = ageTextField.text,
              let aboutYou = aboutYouTextField.text,
              let language = languageTextField.text,
              let nationality = nationalityTextField.text,
              let image = profileImageView.image else { return }
        
        viewModel.createProfile(username: username, age: age, aboutYou: aboutYou, language: language, nationality: nationality, image: image)
              
    }
    
    // MARK: - Helper Functions
    
    private func updateUI() {
        guard let profile = viewModel.profile else { return }
        usernameTextField.text = profile.profileUsername
        ageTextField.text = profile.profileAge
        aboutYouTextField.text = profile.profileAboutYou
        languageTextField.text = profile.profileLanguage
        nationalityTextField.text = profile.profileNationality

        viewModel.getImage { image in
            self.profileImageView.image = image
        }
    }
    
    func setUpImageView() {
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        
    }
    // make segue to transfer information from one view to another
    
    @objc func imageViewTapped() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
}

// MARK: - Extension
extension CreateProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        profileImageView.image = image
    }
}

// MARK: - CreateProfileViewModelDelegate
extension CreateProfileViewController: CreateProfileViewModelDelegate {
    func imageSuccessfullySaved() {
        self.navigationController?.popViewController(animated: true)
    }
}
