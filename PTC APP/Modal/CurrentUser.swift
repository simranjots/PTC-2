//
//  CurrentUser.swift
//  PTC APP
//
//  Created by Simranjot Singh Bagga on 2021-08-10.
//  Copyright © 2021 Gurlagan Bhullar. All rights reserved.
//
import Foundation
import RealmSwift
import Firebase
import FirebaseFirestore
import UIKit
import FirebaseStorage

class CurrentUser {
    
    let realm = try! Realm()
    var users : Results<userModel>?
    //let db = FirebaseDataManager()
    let database = Firestore.firestore()
    // Create a root reference
    let storageRef = Storage.storage().reference()
    typealias userSignIn = (Bool) -> Void
    typealias userAdded = (Int) -> Void
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func addUser(name: String, email: String, password: String,image : Data?,uid : String)-> Int{
        loadUser()
        
        var userNotExist: Bool = true
            
        for user in users._rlmInferWrappedType(){
                
                if(user.email == email){
                    userNotExist = false
                }
                
            }
            
            if(userNotExist){
                let newUser = userModel()
                newUser.name = name
                newUser.email = email
                newUser.uid = uid
                newUser.password = password
                newUser.image = image
                newUser.isloggedin = true
                
                let result = saveUser(user: newUser)
                if result == 0 {
                    return 0
                }
                
            }else {
                print("User Exist")
                return 2
                
            }
        
        
        return 0
        
    }
    
    
    func getUserObject(email: String) -> userModel?{
        var Singleuser = userModel()
        do {
            try realm.write {
                realm.add(users!)
            }
        } catch {
            print("Error saving category \(error)")
        }
        for user in users._rlmInferWrappedType(){
            if user.email == email {
                Singleuser = user
                return Singleuser
            }
            
        }
        return nil
    }
    
    
    func updateUser(oldEmail: String,newEmail: String, name: String, password: String,image: Data?) -> Int {
        
        let userObject = getUserObject(email: oldEmail)
        
        userObject!.name = name
        userObject!.email = newEmail
        userObject!.password = password
        userObject?.image = image
        let result = saveUser(user: userObject!)
        if result == 0 {
            
            let spaceRef = storageRef.child("images/\(userObject!.uid!)/\((userObject?.image)!)")
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            spaceRef.putData((userObject?.image)!, metadata: metaData) { (StorageMetadata, error) in
                guard StorageMetadata != nil else{
                    print("oops an error occured while data uploading")
                    return
                }
                spaceRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        // Uh-oh, an error occurred!
                        return
                    }
                    let urlString: String = downloadURL.absoluteString
                    let userupdate = self.database.collection("dap_users").document(userObject!.uid!)
                    userupdate.updateData(["uid":Auth.auth().currentUser!.uid,
                                  "name": name,
                                  "email":newEmail,
                                  "imageLink":urlString]) { error in
                            if error != nil {
                                print(error as Any)
                            }
                        }
                }
            }
            
            
        }
        return result
        
        
    }
    func updatepassword(Email: String, password: String) -> Int {
        let userObject = getUserObject(email: Email)
        do {
            try realm.write {
                userObject!.password = password
                userObject!.isloggedin = true
               
            }
        } catch {
            print("Error saving done status \(error)")
        }
      
        return 0
    }
    
    func passwordCheck(email: String, password: String) -> Bool {
        loadUser()
        for user in users._rlmInferWrappedType() {
            if user.email == email && user.password == password {
                    return true
            
        }else{
            return false
        }
        }
        return false
        
    }
    func checkUser(email: String) -> Bool{
        loadUser()
        for user in users._rlmInferWrappedType() {
            if user.email == email{
                do {
                    try realm.write {
                        user.isloggedin = true
                    }
                } catch {
                    print("Error saving done status \(error)")
                }
               
                return true
            }
        }
        return false
    }
    
    func updateLoginStatus(status: Bool, email: String) -> Int{
        
        loadUser()
        for user in users._rlmInferWrappedType() {
            if user.email == email{
                do {
                    try realm.write {
                       
                        user.isloggedin = status
                    }
                } catch {
                    print("Error saving done status \(error)")
                }
            }
        }
        return 0
    }
    
    func checkLoggedIn() -> userModel!{
        loadUser()
        for user in users._rlmInferWrappedType(){
            if user.isloggedin == true{
                return user
            }
        }
        return nil
    }

    
    func saveUser(user: userModel)-> Int  {
        do {
            try realm.write {
                realm.add(user)
            }
        } catch {
            print("Error saving category \(error)")
            return 1
        }
        return 0
    }
    
    func loadUser() {
        
        users = realm.objects(userModel.self)
        
        
    }
    func FetchUserData(email: String,completion: @escaping ([userModel]) -> Void) {
        
        let ref = Firestore.firestore().collection("dap_users").whereField("email", isEqualTo: email)
        ref.getDocuments() { (snapshot, error) in
            if error != nil
            {
                
            }
            else {
                completion(snapshot!.documents.compactMap({userModel(value: $0.data())} ))
                return
                
            }
            
            
        }
    }
    
}
    
