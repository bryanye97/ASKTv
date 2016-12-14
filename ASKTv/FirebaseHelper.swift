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

    static func createNewUser(_ rootRef: FIRDatabaseReference) -> FIRDatabaseReference {
        let userRef = rootRef.child("Users").childByAutoId()
        return userRef
    }
    
    static func createUserInformationDictionary(_ username: String, email: String, userId: String) -> [String: AnyObject] {
        return ["username": username as AnyObject, "email": email as AnyObject, "userId": userId as AnyObject]
    }
    
    static func addUser(_ userRef: FIRDatabaseReference, username: String, email: String, userId: String) {
        userRef.childByAutoId().setValue(createUserInformationDictionary(username, email: email, userId: userId))
    }
    
    static func createNewQuestion(_ rootRef: FIRDatabaseReference) -> FIRDatabaseReference {
        let questionRef = rootRef.child("Questions").childByAutoId()
        return questionRef
    }
    
    static func createQuestionInformationDictionary(_ fromUser: String, toUser: String, questionString: String) -> [String: AnyObject] {
        return ["fromUser": fromUser as AnyObject, "toUser": toUser as AnyObject, "questionString": questionString as AnyObject]
    }
    
    static func addQuestion(_ questionRef: FIRDatabaseReference, fromUser: String, toUser: String, questionString: String) {
        questionRef.childByAutoId().setValue(createQuestionInformationDictionary(fromUser, toUser: toUser, questionString: questionString))
    }
    
    static func createNewVideoAnswer(_ rootRef: FIRDatabaseReference) -> FIRDatabaseReference {
        let videoAnswerRef = rootRef.child("VideoAnswers").childByAutoId()
        return videoAnswerRef
    }
    
    static func createVideoInformationDictionary(_ videoUrl: String, questionKey: String) -> [String: AnyObject] {
        return ["videoUrl": videoUrl as AnyObject, "questionKey": questionKey as AnyObject]
    }
    
    static func addVideoAnswer(_ videoAnswerRef: FIRDatabaseReference, videoUrl: String, questionKey: String) {
        videoAnswerRef.childByAutoId().setValue(createVideoInformationDictionary(videoUrl, questionKey: questionKey))
    }

}
