//
//  SignUpViewController.swift
//  ASKTv
//
//  Created by Bryan Ye on 4/08/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    

    @IBOutlet weak var usernameTextField: UITextField!
    
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
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            if error != nil {
                print("error: \(error)")
            } else {
                print("user creation succeeded")
                guard let user = user else { return }
                FirebaseHelper.addUser(ref.child("Users"), username: self.usernameTextField.text!, email: self.emailTextField.text!, userId: user.uid)
            }
            
        })
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signIn" {
            let destinationViewController = segue.destination as! SignInViewController
            destinationViewController.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        }
    }

}
