//
//  ResetPasswordViewController.swift
//  PTC APP
//
//  Created by Jaldeep Patel on 2021-08-04.
//  Copyright © 2021 Gurlagan Bhullar. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var resetPasswordButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Utilities.styleTextField(emailTextField)
        Utilities.styleButton(resetPasswordButtonOutlet)
        
        guard let emailIcon = UIImage(named: "email") else { return }
        Utilities.addTextFieldImage(textField: emailTextField, andImage: emailIcon)
        
    }

    
    @IBAction func resetPasswordButtonTapped(_ sender: UIButton) {
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let auth = Auth.auth()
        auth.sendPasswordReset(withEmail: email) { (error) in
            if error != nil {
                self.showAlert(title: "Error!", message: error!.localizedDescription, buttonTitle: "Try Again")
            } else {
                
                self.showAlert(title: "Hurray!", message: "A password reset request link has been sent on your email. Please check your inbox.", buttonTitle: "OK")
                self.emailTextField.text = ""
            }
        }
    
    }
}
