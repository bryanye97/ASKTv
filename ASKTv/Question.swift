//
//  Question.swift
//  ASKTv
//
//  Created by Bryan Ye on 4/08/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import Foundation
import Firebase

class Question {
    let fromUser: String?
    let toUser: String?
    let questionString: String?
//    let videoAnswer
    
    init(fromUser: String, toUser: String, questionString: String) {
        self.fromUser = fromUser
        self.toUser = toUser
        self.questionString = questionString
    }
    
    init(snap: FIRDataSnapshot) {
        let s = snap.value as! [String: AnyObject]
        fromUser = s["fromUser"] as? String ?? ""
        toUser = s["toUser"] as? String ?? ""
        questionString = s["questionString"] as? String ?? ""
    }
}
