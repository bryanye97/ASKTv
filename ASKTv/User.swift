//
//  User.swift
//  ASKTv
//
//  Created by Bryan Ye on 4/08/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import Foundation
import Firebase
class User {
    
    var username: String?
    var email: String?
    var userId: String?
    
    init(snap: FIRDataSnapshot){
        let s = snap.value as! [String: AnyObject]
        username = s["username"] as? String ?? ""
        email = s["email"] as? String ?? ""
        userId = s["userId"] as? String ?? ""
        
    }
    init(username: String, email: String){
        self.username = username
        self.email = email
    }
    func toString() -> String{
        return "User called: \(username) his mail is \(email)"
    }
}