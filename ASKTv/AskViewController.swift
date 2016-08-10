//
//  AskViewController.swift
//  ASKTv
//
//  Created by Bryan Ye on 4/08/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import UIKit
import Firebase

class AskViewController: UIViewController {
    
    var userArray: [User] = []
    
    var userToView: User?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        ref.child("Users").observeSingleEventOfType(.Value) { (snapshot: FIRDataSnapshot) in
            for snap in snapshot.children {
                let user = User(snap: snap as! FIRDataSnapshot)
                self.userArray.append(user)
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "viewProfile" {
            let destinationViewController = segue.destinationViewController as! ProfileViewController
            destinationViewController.user = userToView
            print("set ProfileViewController user to another user")
        }
     }
 
    
}

extension AskViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        userToView = userArray[indexPath.row]
    
        self.performSegueWithIdentifier("viewProfile", sender: self)
    }
    
}

extension AskViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let user = userArray[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("othersCell") as! AskTableViewCell
        cell.user = user
        cell.delegate = self
        return cell
    }
}

extension AskViewController: AskTableViewCellDelegate {
    func presentAnswerTextField(user: User) {
        print("hello")
        
        let alertController = UIAlertController(title: "Enter question", message: nil, preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler(nil)
        
        let submitAction = UIAlertAction(title: "Submit", style: .Default) { (action) in
            let questionStringTextField = alertController.textFields![0]
            let questionString = questionStringTextField.text ?? ""
            
            guard questionString != "" else { return }
            
            guard let currentUser = FIRAuth.auth()?.currentUser else { return }
            guard let toUserId = user.userId else { return }
            
            FirebaseHelper.addQuestion(ref.child("Questions"), fromUser: currentUser.uid, toUser: toUserId, questionString: questionString)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        alertController.addAction(submitAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
 
    }
}