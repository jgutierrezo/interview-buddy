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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func recoverPassBtnTapped(_ sender: Any) {
        let auth = Auth.auth()
        
        let cleanedEmail = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isValidEmail(cleanedEmail) == false{
            self.feedbackLabel.text = "Not valid email"
            return
        }
        print(emailTF.text!)
        auth.sendPasswordReset(withEmail: emailTF.text!){(error) in
            if let error = error {
                self.feedbackLabel.text = error.localizedDescription
                return
            }
            self.feedbackLabel.text = "Recovery password email sent"
        }
    }
    
}
