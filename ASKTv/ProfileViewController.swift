//
//  ProfileViewController.swift
//  ASKTv
//
//  Created by Bryan Ye on 4/08/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import UIKit
import MobileCoreServices
import Firebase

class ProfileViewController: UIViewController {
    
    var user: User?
    
    @IBOutlet weak var questionsContainerView: UIView!
    
    @IBOutlet weak var answersContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionsContainerView.hidden = false
        answersContainerView.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let questionContainerViewController = self.childViewControllers[0] as! QuestionsContainerViewController
        questionContainerViewController.user = user
        questionContainerViewController.viewWillAppear(animated)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func questionsButtonTapped(sender: UIButton) {
        questionsContainerView.hidden = false
        answersContainerView.hidden = true
    }
    
    @IBAction func answersButtonTapped(sender: UIButton) {
        questionsContainerView.hidden = true
        answersContainerView.hidden = false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "viewQuestions" {
//            print("viewing questions for a user")
//            let destinationViewController = segue.destinationViewController as! QuestionsContainerViewController
//            destinationViewController.user = self.user
//        }
    }
}


//extension ProfileViewController: QuestionTableViewCellDelegate {
//    func takeVideo() {
//    }
//}

