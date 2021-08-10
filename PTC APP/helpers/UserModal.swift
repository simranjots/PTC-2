//
//  UserModal.swift
//  PTC APP
//
//  Created by Simranjot Singh Bagga on 2021-08-10.
//  Copyright © 2021 Gurlagan Bhullar. All rights reserved.
//
import Foundation
import RealmSwift

class userModel: Object  {
    
    @objc dynamic var uid: String?
    @objc dynamic var name: String?
    @objc dynamic var email: String?
    @objc dynamic var password: String?
    @objc dynamic var image: Data?
    @objc dynamic var isloggedin: Bool = false
    @objc dynamic var imageLink : String?
    @objc dynamic var verified : String?

 }
