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
import FirebaseDatabase
import UIKit

class SignUpViewController: UIViewController {
    
    var refusers : DatabaseReference!
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
        refusers = Database.database().reference().child("users")
        styleElements()
        
    }
    
    func validateFields() -> String? {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  || passWordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            print("please fill all the fields")
        }
        
        // password if th password is secure
        let cleanPassword = passWordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanPassword) == false {
            //
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
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
        adduser()
       // FirebaseApp.configure()
       // validateFields()
        //validate the fields
//        let error  = validateFields()
//
//
//        if error != nil{
//
//           showError(error!)
//        }
             // create the user
//        else{
//
//            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//            let password = passWordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//
//            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
//
//                if  err != nil {
//
//                    self.showError("error creating user")
//                }
//                else {
//                    let db = Firestore.firestore()
//                    db.collection("users").addDocument(data: ["firstname": email,"password" : password, "uid": result!.user.uid]) { (error) in
//                        if error != nil {
//
//                            self.showError("user data couln't saved properly")
//                        }
//
//                    }
//                    //
//
//
//                }
//
//            }
//
//        }
        
       
        
        
        //Transition to the home screeen
    }
    func adduser(){
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passWordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let key = refusers.childByAutoId().key
        
        let artist = [ "id" : key, "email" : email ]
        refusers.child(key!).setValue(artist)
        
    }
    func showError(_ message:String) {
        
        //errorMessage.text = message
        //errorMessage.alpha = 1
    }
}
