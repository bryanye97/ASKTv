//
//  VideoHelper.swift
//  ASKTv
//
//  Created by Bryan Ye on 5/08/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import AVKit
import AVFoundation
import UIKit
import MobileCoreServices
import Firebase


class VideoHelper: NSObject {
    weak var viewController: UIViewController!
    
    var question: Question! = nil
    
    var data: NSData?
    
    func startCameraFromViewController(viewController: UIViewController, question: Question) -> Bool {
        self.question = question
        self.viewController = viewController
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) == false {
            print("no camera available")
            return false
        }
        
        let cameraController = UIImagePickerController()
        cameraController.delegate = self
        cameraController.sourceType = .Camera
        cameraController.mediaTypes = [kUTTypeMovie as NSString as String]
        cameraController.allowsEditing = false
        cameraController.cameraDevice = UIImagePickerControllerCameraDevice.Front

        viewController.presentViewController(cameraController, animated: true, completion: nil)
        return true
    }
    

    
    private func handleVideoSelectedForUrl(url: NSURL) {
        let fileName = NSUUID().UUIDString + ".mov"
        let uploadTask = FIRStorage.storage().reference().child("VideoAnswers").child(fileName).putFile(url, metadata: nil) { (metadata, error) in
            guard error == nil else { return }
            
            if let videoUrl = metadata?.downloadURL()?.absoluteString {
                
//                if let thumbnailImage = self.thumbnailImageForFileUrl(url) {
//                    print(thumbnailImage)
//                    print(videoUrl)
//                }
                guard let questionKey = self.question.questionFirebaseKey else { return }
                FirebaseHelper.addVideoAnswer(ref.child("VideoAnswers"), videoUrl: videoUrl, questionKey: questionKey)
            }
            
            
        }
        
        uploadTask.observeStatus(.Progress) { (snapshot: FIRStorageTaskSnapshot) in
            print(snapshot.progress?.completedUnitCount)
        }
        
        uploadTask.observeStatus(.Success) { (snapshot: FIRStorageTaskSnapshot) in
            print("Video upload success")
        }
    }
    
    private func thumbnailImageForFileUrl(fileUrl: NSURL) -> UIImage? {
        let asset = AVAsset(URL: fileUrl)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImageAtTime(CMTimeMake(1, 60), actualTime: nil)
            
            return UIImage(CGImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        
        return nil
    }
    
    
    
}

extension VideoHelper: UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let videoUrl = info[UIImagePickerControllerMediaURL] as? NSURL {
            handleVideoSelectedForUrl(videoUrl)
        }
        
        self.viewController.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension VideoHelper: UINavigationControllerDelegate {
    
}
