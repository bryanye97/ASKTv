//
//  VideoAnswers.swift
//  ASKTv
//
//  Created by Bryan Ye on 11/08/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import Foundation
import Firebase

class VideoAnswer {
    
    var videoUrl: String
    var questionKey: String
    
    init(snap: FIRDataSnapshot) {
        let s = snap.value as! [String: AnyObject]
        videoUrl = s["videoUrl"] as? String ?? ""
        questionKey = s["questionKey"] as? String ?? ""
    }
    
}