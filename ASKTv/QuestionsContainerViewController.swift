//
//  QuestionsContainerViewController.swift
//  ASKTv
//
//  Created by Bryan Ye on 6/08/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import UIKit
import Firebase

class QuestionsContainerViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var user: User?
    
    var questionsForUser: [Question] = []
    
    var videoHelper = VideoHelper()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.tabBarController?.selectedIndex == 1 {
            let questionsRef = ref.child("Questions")
            
            guard let userToQuery = self.user else { return }
            let questionsForUser = questionsRef.queryOrderedByChild("toUser").queryEqualToValue(userToQuery.userId)
            
            questionsForUser.observeEventType(.Value) { (snapshot: FIRDataSnapshot) in
                self.questionsForUser = []
                for snap in snapshot.children {
                    let question = Question(snap: snap as! FIRDataSnapshot)
                    self.questionsForUser.append(question)
                }
                self.tableView.reloadData()
            }
        } else if self.tabBarController?.selectedIndex == 2 {
            let userRef = ref.child("Users")
            let queryForCurrentUser = userRef.queryOrderedByChild("userId").queryEqualToValue(FIRAuth.auth()?.currentUser?.uid)
            queryForCurrentUser.observeSingleEventOfType(.Value, withBlock: { (snapshot: FIRDataSnapshot) in
                for snap in snapshot.children {
                    self.user = User(snap: snap as! FIRDataSnapshot)
                    
                    let questionsRef = ref.child("Questions")
                    
                    guard let userToQuery = self.user else { return }
                    let questionsForUser = questionsRef.queryOrderedByChild("toUser").queryEqualToValue(userToQuery.userId)
                    
                    questionsForUser.observeEventType(.Value) { (snapshot: FIRDataSnapshot) in
                        self.questionsForUser = []
                        for snap in snapshot.children {
                            let question = Question(snap: snap as! FIRDataSnapshot)
                            self.questionsForUser.append(question)
                        }
                        self.tableView.reloadData()
                    }
                }
            })
        }
    }
    
    
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

extension QuestionsContainerViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("selected: \(indexPath.row)")
    }
}

extension QuestionsContainerViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let question = questionsForUser[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("questionCell") as! QuestionTableViewCell
        cell.question = question
        cell.delegate = self
        cell.backgroundColor = UIColor.orangeColor()
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionsForUser.count
    }
}

extension QuestionsContainerViewController: QuestionTableViewCellDelegate {
    func takeVideo() {
        let question = Question(fromUser: "fromUser: random", toUser: "toUser: random", questionString: "TestQuestion?")
        
        videoHelper.startCameraFromViewController(self, question: question)
    }
}
