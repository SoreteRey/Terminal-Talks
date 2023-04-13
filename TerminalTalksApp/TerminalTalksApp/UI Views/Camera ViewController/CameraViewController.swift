//
//  CameraViewController.swift
//  TerminalTalksApp
//
//  Created by Sebastian Guiscardo on 4/12/23.
//

import UIKit
import AVFoundation


class CameraViewController: UIViewController {

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		test()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: animated)
		self.tabBarController?.tabBar.isHidden = true
	}

	// MARK: - Functions

	func test() {
		let imagePickerController = UIImagePickerController()
		imagePickerController.delegate = self
		imagePickerController.sourceType = .camera
		present(imagePickerController, animated: true, completion: nil)
	}
}

// MARK: - Extension
extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
		// Do whatever you need to do here. Idk. Ex:
		let imageView = UIImageView(image: image)
		view.addSubview(imageView)
		picker.dismiss(animated: true, completion: nil)
	}

	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		picker.dismiss(animated: true, completion: nil)
		navigationController?.popViewController(animated: true)
	}
}
