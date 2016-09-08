//
//  SignInViewController.swift
//  ASKTv
//
//  Created by Bryan Ye on 4/08/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInButtonTapped(sender: AnyObject) {
        self.signIn()
    }
    
    
    func signIn() {
        FIRAuth.auth()?.signInWithEmail(emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            if error != nil {
                print("login failed: \(error)")
            } else {
                print("login succeeded")
                
                self.performSegueWithIdentifier("didSignIn", sender: self)
            }
        })
    }





    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "signUp" {
            let destinationViewController = segue.destinationViewController as! SignUpViewController
            destinationViewController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        }
    }
 

}
