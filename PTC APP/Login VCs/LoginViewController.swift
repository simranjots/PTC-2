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

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet var signInButtonOutlet: UIButton!
    @IBOutlet var tagLineLabel: UILabel!
    //@IBOutlet weak var errorLabel: UILabel!
    var isIconClicked = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleElements()
    }

    @IBAction func loginPressed(_ sender: Any) {
        
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passWordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                //self.errorLabel.text = error!.localizedDescription
                //self.errorLabel.alpha = 1
            }
            else {
                
         print("logged in succesfully")
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
    
    
}

