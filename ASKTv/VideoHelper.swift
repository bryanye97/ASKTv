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
    
    var data: Data?
    
    func startCameraFromViewController(_ viewController: UIViewController, question: Question) -> Bool {
        self.question = question
        self.viewController = viewController
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) == false {
            print("no camera available")
            return false
        }
        
        let cameraController = UIImagePickerController()
        cameraController.delegate = self
        cameraController.sourceType = .camera
        cameraController.mediaTypes = [kUTTypeMovie as NSString as String]
        cameraController.allowsEditing = false
        cameraController.cameraDevice = UIImagePickerControllerCameraDevice.front

        viewController.present(cameraController, animated: true, completion: nil)
        return true
    }
    

    
    fileprivate func handleVideoSelectedForUrl(_ url: URL) {
        let fileName = UUID().uuidString + ".mov"
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
        
        uploadTask.observe(.progress) { (snapshot: FIRStorageTaskSnapshot) in
            print(snapshot.progress?.completedUnitCount)
        }
        
        uploadTask.observe(.success) { (snapshot: FIRStorageTaskSnapshot) in
            print("Video upload success")
        }
    }
    
    fileprivate func thumbnailImageForFileUrl(_ fileUrl: URL) -> UIImage? {
        let asset = AVAsset(url: fileUrl)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(1, 60), actualTime: nil)
            
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        
        return nil
    }
    
    
    
}

extension VideoHelper: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let videoUrl = info[UIImagePickerControllerMediaURL] as? URL {
            handleVideoSelectedForUrl(videoUrl)
        }
        
        self.viewController.dismiss(animated: true, completion: nil)
    }
}

extension VideoHelper: UINavigationControllerDelegate {
    
}
