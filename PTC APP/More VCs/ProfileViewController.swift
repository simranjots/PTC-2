//
//  ProfileViewController.swift
//  PTC APP
//
//  Created by Jaldeep Patel on 2021-08-05.
//  Copyright © 2021 Gurlagan Bhullar. All rights reserved.
//

import UIKit
import MobileCoreServices
import Firebase


class ProfileViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var updateProfileButtonOutlet: UIButton!
    @IBOutlet var profileImageEditButtonOutlet: UIButton!
    var user : CurrentUser!
    var userObject: userModel!
    var email = ""
    var Password = ""
    var isIconClicked = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleElements()
        user = CurrentUser()
        userObject = user.checkLoggedIn()
       
        setUpData()
    }
    
    func styleElements() {
        
        //TextField Icons
        guard let emailIcon = UIImage(named: "email") else { return }
        guard let passwordLeftIcon = UIImage(named: "password") else { return }
        guard let passwordRightIcon = UIImage(named: "openEye") else { return }
        guard let profileIcon = UIImage(named: "profile") else { return }
        
        //Style TextFields
        Utilities.addBottomLineToTextField(nameTextField)
        Utilities.addTextFieldImage(textField: nameTextField, andImage: profileIcon)
        Utilities.addBottomLineToTextField(emailTextField)
        Utilities.addTextFieldImage(textField: emailTextField, andImage: emailIcon)
        Utilities.addBottomLineToTextField(passwordTextField)
        Utilities.addTextFieldImage(textField: passwordTextField, andImage: passwordLeftIcon)
        addPasswordEyeIcon(textField: passwordTextField, andImage: passwordRightIcon)
        
        //Style ImageView
        profileImageView.layer.cornerRadius = 60
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.borderColor = Utilities.secondaryTextColor.cgColor
        
        //Style Button
        Utilities.styleButton(updateProfileButtonOutlet)
    }
    func setUpData() {
        guard let passwordRightIcon = UIImage(named: "openEye") else { return }
        addPasswordEyeIcon(textField: passwordTextField, andImage: passwordRightIcon)
        nameTextField.text = userObject.name
        emailTextField.text = userObject.email
        passwordTextField.text = userObject.password
        email = userObject.email!
        if userObject.image != nil {
            profileImageView.image  = UIImage(data: userObject.image!)
        }
        Password = userObject.password!
   
    }
    
    //MARK: - Update Profile and Image
    @IBAction func profileImageEditButtonTapped(_ sender: UIButton) {
        actionSheet()
    }
    
    @IBAction func updateProfileTapped(_ sender: UIButton) {
        let newEmail = emailTextField.text!
        let newpassword = passwordTextField.text!
        let newName = nameTextField.text!
        let data = UIImage(named: "profileImage")?.jpegData(compressionQuality: 1.0)
        let imageData = profileImageView.image?.jpegData(compressionQuality: 1.0)
        let credential = EmailAuthProvider.credential(withEmail: email, password: Password)
        let user = Auth.auth().currentUser
        user?.reauthenticate(with: credential, completion: { Result, Error in
            if Error !=  nil {
            }else{
//                Auth.auth().currentUser?.updateEmail(to: newEmail) { error in
//                    if error != nil {
//                        self.showAlert(title: "warning", message: "The email address is already in use by another account.", buttonTitle: "try again")
//                    }else{
//                        let result = self.user.updateUser(oldEmail: self.email, newEmail: newEmail, name: newName, password: newpassword, image: imageData ?? data)
//                        if result == 0 {
//                            self.showToast(message: "Successfully updated", duration: 2.0)
//                            _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
//                                self.navigationController?.popViewController(animated: true)
//                            }
//
//
//                        } else {
//
//                            self.showToast(message: "Updation Fail. . .", duration: 2.0)
//
//                        }
//                    }
//                }
                Auth.auth().currentUser?.updatePassword(to: newpassword) { error in
                    if error != nil {
                        self.showAlert(title: "warning", message: "\(String(describing: error))" , buttonTitle: "tryagain")
                    }else{
                        let result = self.user.updateUser(oldEmail: self.email, newEmail: newEmail, name: newName, password: newpassword, image: imageData ?? data)
                        if result == 0 {
                            self.showToast(message: "Successfully updated", duration: 2.0)
                            _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
                                self.navigationController?.popViewController(animated: true)
                            }
                         
                            
                        } else {
                          
                            self.showToast(message: "Updation Fail. . .", duration: 2.0)
                            
                        }
                    }
                    
                }
            }
        })
       
    }
    
    //MARK: - Right imageIcon for password textfield
    func addPasswordEyeIcon(textField: UITextField, andImage image: UIImage) {
        
        //Create textField view
        let textFieldRightView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        //Create textField subview and add image
        let textFieldImageView = UIImageView(image: image)
        
        //Set subview frame
        textFieldImageView.frame = CGRect(x: 0, y: 8, width: 25, height: 25)
        
        //Add subview
        textFieldRightView.addSubview(textFieldImageView)
        
        //Set leftside textField properties
        textField.rightView = textFieldRightView
        textField.rightViewMode = .always
        
        
        //Add color to textField Image
        textFieldImageView.tintColor = Utilities.primaryTextColor
        
        //Add Tap Gesture
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(eyeImageTapped(tapGestureRecognizer: )))
        textFieldImageView.isUserInteractionEnabled = true
        textFieldImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func eyeImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if isIconClicked {
            isIconClicked = false
            tappedImage.image = UIImage(named: "closedEye")
            passwordTextField.isSecureTextEntry = false
            
        } else {
            isIconClicked = true
            tappedImage.image = UIImage(named: "openEye")
            passwordTextField.isSecureTextEntry = true
        }
        
    }
    
    //MARK: - Helper functions to option gallary or camera
    
    func actionSheet() {
        
        let alert = UIAlertController(title: "Choose Image from: ", message: nil, preferredStyle: .actionSheet)
        
        //To open camera
        alert.addAction(UIAlertAction(title: "Open Camera", style: .default, handler: { (handler) in
            self.openCamera()
        }))
        
        //To open gallery
        alert.addAction(UIAlertAction(title: "Open Gallery", style: .default, handler: { (handler) in
            self.openGallery()
        }))
        
        //To Cancel
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        //Action controller for iPad
        if UIDevice.current.userInterfaceIdiom == .pad {
            alert.popoverPresentationController?.permittedArrowDirections = .right
            alert.popoverPresentationController?.sourceView = profileImageEditButtonOutlet
        }
    
        present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let image = UIImagePickerController()
            image.sourceType = .camera
            image.allowsEditing = true
            image.delegate = self
            //image.mediaTypes = [kUTTypeImage as String]
            present(image, animated: true)
        }
    }
    
    func openGallery() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let image = UIImagePickerController()
            image.sourceType = .photoLibrary
            image.allowsEditing = true
            image.delegate = self
            present(image, animated: true)
        }
    }
}

//MARK: - Extension for UIImagePickerViewController

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            profileImageView.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
