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

class signUpController: UIViewController {
    
    var refusers : DatabaseReference!
  // var ref : DatabaseReference!
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        refusers = Database.database().reference().child("users")
        
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
        
        errorMessage.text = message
        errorMessage.alpha = 1
    }
}
