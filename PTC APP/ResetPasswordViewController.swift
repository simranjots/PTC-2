//
//  ResetPasswordViewController.swift
//  PTC APP
//
//  Created by Jaldeep Patel on 2021-08-04.
//  Copyright © 2021 Gurlagan Bhullar. All rights reserved.
//

import UIKit

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
    
    
    }
}
