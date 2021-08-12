//
//  signUpController.swift
//  PTC APP
//
//  Created by Gurlagan Bhullar on 2020-02-04.
//  Copyright © 2020 Gurlagan Bhullar. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseDatabase
import UIKit

class SignUpViewController: UIViewController {
    
    var refusers : DatabaseReference!
    var currentUser : CurrentUser!

    let db = Firestore.firestore()
  // var ref : DatabaseReference!
    
    
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    //@IBOutlet weak var errorMessage: UILabel!
    @IBOutlet var signUpButtonOutlet: UIButton!
    var isIconClicked = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currentUser = CurrentUser()
        styleElements()
        
    }
    
    func validateFields() -> String? {
        
        //Check that all the fields are filled
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passWordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill all the fields."
        }
        
        //Check email format is valid
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isEmailValid(cleanedEmail) == false {
            return "Please make sure you have entered valid email format."
        }
        
        //Check password is secured
        let cleanedPassword = passWordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password is at least 8 charactors, contains at least one upper case letter, a special charactor and a number."
        }
        return nil
    }
    
    
    func styleElements() {
        
        //Style textFields
        Utilities.styleTextField(nameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passWordTextField)
        
        //Style button
        Utilities.styleButton(signUpButtonOutlet)
        Utilities.addShadowToButton(signUpButtonOutlet)
        
        //Disappear error label
        //errorMessage.alpha = 0
        
        //Add textfields icons
        guard let profileIcon = UIImage(named: "profile") else { return }
        guard let emailIcon = UIImage(named: "email") else { return }
        guard let passwordLeftIcon = UIImage(named: "password") else { return }
        guard let passwordRightIcon = UIImage(named: "openEye") else { return }
        
        Utilities.addTextFieldImage(textField: nameTextField, andImage: profileIcon)
        Utilities.addTextFieldImage(textField: emailTextField, andImage: emailIcon)
        Utilities.addTextFieldImage(textField: passWordTextField, andImage: passwordLeftIcon)
        addPasswordEyeIcon(textField: passWordTextField, andImage: passwordRightIcon)
        
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
            passWordTextField.isSecureTextEntry = false
            
        } else {
            isIconClicked = true
            tappedImage.image = UIImage(named: "openEye")
            passWordTextField.isSecureTextEntry = true
        }
        
    }
    

    @IBAction func signUpTapped(_ sender: UIButton) {
        let error = validateFields()
        
        if error != nil {
            
            showAlert(title: "Warning!", message: error! , buttonTitle: "Try Again")
            
        } else {
            
            let userName = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            var email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passWordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            email = email.lowercased()
            
            if(!userName.isEmpty && !email.isEmpty && !password.isEmpty){
                
                if(email.isValidEmail){
                    if(password.isValidPassword){
                        //Create the user
                        Auth.auth().createUser(withEmail: email, password: password) { result, err in
                            if err != nil {
                                //There was an error creating the user
                                self.showAlert(title: "Error!", message: err!.localizedDescription , buttonTitle: "Try Again")
                            } else {
                                
                                
                                DispatchQueue.global().async {
                                    let imagepath = "https://firebasestorage.googleapis.com/v0/b/dayachievementprinciple.appspot.com/o/Profile%2FprofileImage1-2.png?alt=media&token=58f52b23-2cf9-4558-81b0-3d8c9545622d"
                                    let fileUrl = URL(string: imagepath)
                                    // Fetch Image Data
                                    if let data = try? Data(contentsOf: fileUrl!) {
                                        DispatchQueue.main.async {
                                            // Create Image and Update Image View
                                            let imagedownloaded = UIImage(data: data)
                                            let image = imagedownloaded?.jpegData(compressionQuality: 1.0)
                                            let flag = self.currentUser.addUser(name: userName, email: email, password: password, image: image, uid: Auth.auth().currentUser!.uid)
                                            if(flag == 1){
                                                
                                                self.showAlert(title: "Warning", message: "User Already Exist", buttonTitle: "Try Again")
                                                
                                                
                                            }else if (flag == 2){
                                                
                                                self.showAlert(title: "Error", message: "Please Report an error. . .", buttonTitle: "Try Again")
                                                
                                            }else if (flag == 0){
                                                
                                                self.db.collection("pow_users").document(Auth.auth().currentUser!.uid)
                                                    .setData(["uid":Auth.auth().currentUser!.uid,
                                                              "name": userName,
                                                              "email":email,
                                                              "imageLink":imagepath,
                                                              "verified":"Not Verified"]) { error in
                                                        if error != nil {
                                                            self.showAlert(title: "Error!", message: error!.localizedDescription , buttonTitle: "Try Again")
                                                        }
                                                    }
                                                if Auth.auth().currentUser != nil && Auth.auth().currentUser!.isEmailVerified {
                                                    self.showAlert(title: "Error!", message: err!.localizedDescription , buttonTitle: "Try Again")
                                                    }
                                                    else {
                                                        Auth.auth().currentUser!.sendEmailVerification(completion: { (error) in
                                                            if error != nil {
                                                                self.showAlert(title: "Error!", message: error!.localizedDescription , buttonTitle: "Try Again")
                                                            }
                                                                // Notify the user that the mail has sent or couldn't because of an error.
                                                            
                                                        let alert = UIAlertController(title: "Email Sent", message: "An email verification link has been sent to your email. Please check your email.", preferredStyle: .alert)
                                                              alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction) -> Void in
                                                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                                                let vc = storyboard.instantiateViewController(withIdentifier: "LoginScreen") as! LoginViewController
                                                                self.present(vc, animated: true, completion: nil)
                                                              }))
                                                      
                                                            
                                                        self.present(alert, animated: true, completion: nil)
                                                            })
                                                    
                                                       
                                                        
                                                    }
                                            }
                                        }
                                    }
                                }
                                
                                
                                
                            }
                        }
                        
                        
                    }else{
                        showToast(message: "Enter Valid Password", duration: 1.0)
                    }
                }else{
                    showToast(message: "Enter Valid Email", duration: 1.0)
                }
                
                
            }
            else{
                
                print("fill the form")
                
            }
            
        }
    }
    
    func adduser(){
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //let password = passWordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let key = refusers.childByAutoId().key
        
        let artist = [ "id" : key, "email" : email ]
        refusers.child(key!).setValue(artist)
        
    }
    func showError(_ message:String) {
        
        //errorMessage.text = message
        //errorMessage.alpha = 1
    }
}
