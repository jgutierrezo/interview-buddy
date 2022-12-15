//
//  ResetPasswordViewController.swift
//  interview-buddy
//
//  Created by Juan David Gutierrez Ochoa on 2022-11-25.
//

import UIKit
import Firebase


class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    

    //This action is triggered when the user taps the recover password button.
    @IBAction func recoverPassBtnTapped(_ sender: Any) {
        //Initializing an instance of Auth
        let auth = Auth.auth()
        
        //Cleaning the email string by removing whitespaces and newlines
        let cleanedEmail = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Checking if the email is valid
        if Utilities.isValidEmail(cleanedEmail) == false{
            //If the email is not valid, displaying an error message
            self.feedbackLabel.text = "Not valid email"
            return
        }
        //Printing the email
        print(emailTF.text!)
        //Sending a password reset email to the specified email
        auth.sendPasswordReset(withEmail: emailTF.text!){(error) in
            //If there is an error, displaying it
            if let error = error {
                self.feedbackLabel.text = error.localizedDescription
                return
            }
            //If the password reset email was sent, displaying a success message
            self.feedbackLabel.text = "Recovery password email sent"
        }
    }
    
}
