//
//  FirebaseHelper.swift
//  ASKTv
//
//  Created by Bryan Ye on 4/08/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import Foundation
import Firebase

class FirebaseHelper {


    

    static func createNewUser(rootRef: FIRDatabaseReference) -> FIRDatabaseReference {
        let userRef = rootRef.child("Users").childByAutoId()
        return userRef
    }
    
    static func createUserInformationDictionary(username: String, email: String, userId: String) -> [String: AnyObject] {
        return ["username": username, "email": email, "userId": userId]
    }
    
    static func addUser(userRef: FIRDatabaseReference, username: String, email: String, userId: String) {
        userRef.childByAutoId().setValue(createUserInformationDictionary(username, email: email, userId: userId))
    }
    
    static func createNewQuestion(rootRef: FIRDatabaseReference) -> FIRDatabaseReference {
        let questionRef = rootRef.child("Questions").childByAutoId()
        return questionRef
    }
    
    static func createQuestionInformationDictionary(fromUser: String, toUser: String, questionString: String) -> [String: AnyObject] {
        return ["fromUser": fromUser, "toUser": toUser, "questionString": questionString]
    }
    
    static func addQuestion(questionRef: FIRDatabaseReference, fromUser: String, toUser: String, questionString: String) {
        questionRef.childByAutoId().setValue(createQuestionInformationDictionary(fromUser, toUser: toUser, questionString: questionString))
    }

}