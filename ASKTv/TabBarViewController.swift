//
//  TabBarViewController.swift
//  ASKTv
//
//  Created by Bryan Ye on 6/08/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import UIKit
import Firebase

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.delegate = self
    }
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        let userRef = ref.child("Users")
//        let queryForCurrentUser = userRef.queryOrderedByChild("userId").queryEqualToValue(FIRAuth.auth()?.currentUser?.uid)
//        queryForCurrentUser.observeSingleEventOfType(.Value, withBlock: { (snapshot: FIRDataSnapshot) in
//            for snap in snapshot.children {
//                currentUser = User(snap: snap as! FIRDataSnapshot)
//            }
//        })
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension TabBarViewController: UITabBarControllerDelegate {
//    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
//        if viewController is ProfileViewController {
//            let destinationViewController = viewController as! ProfileViewController
//            destinationViewController.user = currentUser
//        }
//    }
//}
