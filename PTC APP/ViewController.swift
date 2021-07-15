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



class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        emailTextField.layer.cornerRadius = 15
        emailTextField.layer.borderWidth = 0.1
             
    }

    @IBAction func loginPressed(_ sender: Any) {
        
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passWordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                
         print("logged in succesfully")
            }
        }
    }
    
}

