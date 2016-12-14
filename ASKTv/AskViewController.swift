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
        
        ref.child("Users").observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
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
    
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewProfile" {
            let destinationViewController = segue.destination as! ProfileViewController
            destinationViewController.user = userToView
            print("set ProfileViewController user to another user")
        }
     }
 
    
}

extension AskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userToView = userArray[indexPath.row]
    
        self.performSegue(withIdentifier: "viewProfile", sender: self)
    }
    
}

extension AskViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = userArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "othersCell") as! AskTableViewCell
        cell.user = user
        cell.delegate = self
        return cell
    }
}

extension AskViewController: AskTableViewCellDelegate {
    func presentAnswerTextField(_ user: User) {
        print("hello")
        
        let alertController = UIAlertController(title: "Enter question", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { (action) in
            let questionStringTextField = alertController.textFields![0]
            let questionString = questionStringTextField.text ?? ""
            
            guard questionString != "" else { return }
            
            guard let currentUser = FIRAuth.auth()?.currentUser else { return }
            guard let toUserId = user.userId else { return }
            
            FirebaseHelper.addQuestion(ref.child("Questions"), fromUser: currentUser.uid, toUser: toUserId, questionString: questionString)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        alertController.addAction(submitAction)
        
        self.present(alertController, animated: true, completion: nil)
 
    }
}
