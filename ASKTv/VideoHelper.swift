//
//  VideoHelper.swift
//  ASKTv
//
//  Created by Bryan Ye on 5/08/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import AVKit
import UIKit
import MobileCoreServices


class VideoHelper: NSObject {
    weak var viewController: UIViewController!
    
    var question: Question! = nil
    
    var data: NSData?
    
//    init(viewController: UIViewController) {
//            super.init()
//        }
    
    
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
    
    func video(videoPath: NSString, didFinishSavingWithError error: NSError?, contextInfo info: AnyObject) {
        var title = "Success"
        var message = "Video was saved"
        if let _ = error {
            title = "Error"
            message = "Video failed to save"
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
}

extension VideoHelper: UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("did pick media with info")
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        picker.dismissViewControllerAnimated(true, completion: nil)
        print("video done \(info)")
        if mediaType == kUTTypeMovie {
            let url = info[UIImagePickerControllerMediaURL] as! NSURL
            data = NSData(contentsOfURL: url)
            
            //            guard let path = (info[UIImagePickerControllerMediaURL] as! NSURL).path else { return }
            //            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path) {
            //                UISaveVideoAtPathToSavedPhotosAlbum(path, self, #selector(video(_:didFinishSavingWithError:contextInfo:)), nil)
            //            }
            //        }
            //    }
            
        }
    }
}

extension VideoHelper: UINavigationControllerDelegate {
    
}
