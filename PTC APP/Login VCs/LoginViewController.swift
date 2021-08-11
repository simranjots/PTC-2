//
//  ViewController.swift
//  PTC APP
//
//  Created by Gurlagan Bhullar on 2020-01-30.
//  Copyright © 2020 Gurlagan Bhullar. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {

    //Dabase initilizers
    var currentUser : CurrentUser!
    var userObjectPass: User!
    let db = Firestore.firestore()
    var userSetup = [userModel]()
    let storageRef = Storage.storage().reference()
    private var rememberMeFlag = false
    
    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet var signInButtonOutlet: UIButton!
    @IBOutlet var tagLineLabel: UILabel!
    //@IBOutlet weak var errorLabel: UILabel!
    var isIconClicked = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        currentUser = CurrentUser()
        rememberMeFlag = UserDefaults.standard.bool(forKey: "REMEMBER_USER")
        if rememberMeFlag {
            checkbox.setImage(UIImage(named: "check"), for: .normal)
            let email = UserDefaults.standard.string(forKey: "USER_EMAIL")
            emailTextField.text = email
        }else{
            checkbox.setImage(UIImage(named: "uncheck"), for: .normal)
        }
        styleElements()
    }

    @IBAction func checkBtn(_ sender: Any) {
        rememberMeFlag = !rememberMeFlag
        UserDefaults.standard.set(rememberMeFlag, forKey: "REMEMBER_USER")
        if rememberMeFlag {
            checkbox.setImage(UIImage(named: "check"), for: .normal)
            let text = emailTextField.text
            UserDefaults.standard.set(text, forKey:"USER_EMAIL")
        }else{
            checkbox.setImage(UIImage(named: "uncheck"), for: .normal)
            UserDefaults.standard.removeObject(forKey: "USER_EMAIL")
        }
    }
    @IBAction func loginPressed(_ sender: Any) {
        view.endEditing(true)
        
        activityIndicator.startAnimating()
        
        let error = validateFields()
        
        if error != nil {
            
            showToast(message: error!, duration: 2.0)
            
        } else {
            
            var email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passWordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            email = email.lowercased()
            if(email.isValidEmail) {
                if(password.isValidPassword) {
                    Auth.auth().signIn(withEmail: email, password: password) {[weak self] (success,message) in
                        guard let self = self else { return }
                        if message != nil {
                            self.showAlert(title: "Error!", message: message!.localizedDescription, buttonTitle: "Try Again")
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.isHidden = true
                        }
                        if (success != nil) {
                        if (Auth.auth().currentUser?.isEmailVerified)! {
                            let userupdate = self.db.collection("pow_users").document(Auth.auth().currentUser!.uid)
                            userupdate.updateData([
                                "verified": "Verified"
                            ]) { err in
                                if let err = err {
                                    print("Error updating document: \(err)")
                                } else {
                                    print("Document successfully updated")
                                }
                            }
                            if self.currentUser.checkUser(email: email) {
                                if self.currentUser.passwordCheck(email: email, password: password){
                                    let save = self.currentUser.updateLoginStatus(status: true, email: email)
                                    if save == 0 {
                                       
                                            self.performSegue(withIdentifier: Constants.Segues.signInToHomeSegue, sender: self)
                                            
                                    }
                                    
                                }else{
                                    let saved =  self.currentUser.updatepassword(Email: email, password: password)
                                    if saved == 0 {
                                       
                                            self.performSegue(withIdentifier: Constants.Segues.signInToHomeSegue, sender: self)
                        
                                    }
                                }
                            }else{
                                self.currentUser.FetchUserData(email: email, completion: { (users) in
                                    self.userSetup = users
                                    for user in self.userSetup {
                                        
                                        if user.email == email {
                                            let fileUrl = URL(string: user.imageLink!)
                                            
                                            // Fetch Image Data
                                            if let data = try? Data(contentsOf: fileUrl!) {
                                                
                                                // Create Image and Update Image View
                                                let imagedownloaded = UIImage(data: data)
                                                let image = imagedownloaded?.jpegData(compressionQuality: 1.0)
                                                let out = self.currentUser.addUser(name: user.name!, email: email, password: password, image: image, uid: (success?.user.uid)!)
                                                if(out == 0){
                                                   
                                                        self.performSegue(withIdentifier: Constants.Segues.signInToHomeSegue, sender: self)
                                                        
                                                   
                                                }else{
                                                    self.showAlert(title: "Login Fail", message: "Invalid Login Credentials. . .", buttonTitle: "Try Again")
                                                    self.activityIndicator.stopAnimating()
                                                    self.activityIndicator.isHidden = true
                                                }
                                            }
                                        }
                                    }
                                })
                            }
                            
                            
                        }else{
                            self.showAlert(title: "Login Fail", message: "Please verify your email. An email verification link has already sent on your email.", buttonTitle: "OK")
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.isHidden = true
                        }
                    }else{
                            self.showAlert(title: "Login Fail", message: "Please verify your email. An email verification link has already sent on your email.", buttonTitle: "OK")
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.isHidden = true
                        }
                        
                    }
                    
                    
                    
                } else {
                    showToast(message: "Enter Valid Password", duration: 2.0)
                    activityIndicator.stopAnimating()
                    activityIndicator.isHidden = true
                }
            } else {
                showToast(message: "Enter Valid Email", duration: 2.0)
                activityIndicator.stopAnimating()
                activityIndicator.isHidden = true
            }
        }
    }
    
    func styleElements() {
        
        //Style textFields
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passWordTextField)
        
        //Style button
        Utilities.styleButton(signInButtonOutlet)
        Utilities.addShadowToButton(signInButtonOutlet)
        
        //Disappear error label
        //errorLabel.alpha = 0
        
        //Add textfields icons
        guard let emailIcon = UIImage(named: "email") else { return }
        guard let passwordLeftIcon = UIImage(named: "password") else { return }
        guard let passwordRightIcon = UIImage(named: "openEye") else { return }
        
        Utilities.addTextFieldImage(textField: emailTextField, andImage: emailIcon)
        Utilities.addTextFieldImage(textField: passWordTextField, andImage: passwordLeftIcon)
        addPasswordEyeIcon(textField: passWordTextField, andImage: passwordRightIcon)
        
        //Animate Tagline text
        tagLineLabel.text = ""
        var charIndex = 0.0
        let taglineText = "Creating Communication That Gets Results"
        
        for letters in taglineText {
            
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { timer in
                self.tagLineLabel.text?.append(letters)
            }
            charIndex += 1
        }
    }
    
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
        textFieldImageView.tintColor = UIColor(named: "BrandColor")
        
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
            passWordTextField.isSecureTextEntry = false
            
        } else {
            isIconClicked = true
            tappedImage.image = UIImage(named: "openEye")
            passWordTextField.isSecureTextEntry = true
        }
        
    }
    func validateFields() -> String? {
        
        //Validate any field is not blank
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passWordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            return "Email or password are blank."
        }
        
        //Validate Email format is correct
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isEmailValid(cleanedEmail) == false {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            return "Please enter correct email."
        }
        
        //Validate password is correct
        let cleanedPassword = passWordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            return "Please enter correct password."
        }
        
        return nil
    }
    
    
}

