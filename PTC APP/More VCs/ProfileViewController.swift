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
        profileImageView.layer.borderColor = Utilities.brandRedColor.cgColor
        
        //Style Button
        Utilities.styleButton(updateProfileButtonOutlet)
        
        //Add tapgesture to ProfileImage View
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureFired(_:)))
        gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.numberOfTouchesRequired = 1
        profileImageView.addGestureRecognizer(gestureRecognizer)
        profileImageView.isUserInteractionEnabled = true
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
    
    @objc func gestureFired(_ gesture: UITapGestureRecognizer) {
        actionSheet()
    }
    
    @IBAction func updateProfileTapped(_ sender: UIButton) {
        
        let error = validateFields()
        
        if error != nil {
            
        } else {
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
                                self.showToast(message: "Successfully updated", duration: 2.0, height: 30)
                                _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
                                    self.navigationController?.popViewController(animated: true)
                                }
                             
                            } else {
                              
                                self.showToast(message: "Updation Fail. . .", duration: 2.0, height: 30)
                            }
                        }
                    }
                }
            })
        }
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
        textFieldImageView.tintColor = UIColor(named: Constants.Colors.brandColor)
        
        //Add Tap Gesture
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(eyeImageTapped(tapGestureRecognizer: )))
        textFieldImageView.isUserInteractionEnabled = true
        textFieldImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //Check the fields and validate that the data is correct. If everything is correct, this method returns
    // nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        //Check that all the fields are filled
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            showToast(message: "Please fill all the fields.", duration: 2.0, height: 30)
            return "nil"
        }
        
        //Check Profile name is not containing any special characters.
        let cleanedProfileName = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isStringValid(cleanedProfileName) == true {
            showToast(message: "Special characters or numbers are not allowed in Profile Name.", duration: 2.0, height: 20)
            return "nil"
        }
        
        //Check password is secured
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            showToast(message: "Please make sure your password is at least 8 characters, contains at least one upper case letter, a special charactor and a number.", duration: 2.0, height: 0)
            return "nil"
        }
        return nil
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
            let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera;
                imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)    }
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
