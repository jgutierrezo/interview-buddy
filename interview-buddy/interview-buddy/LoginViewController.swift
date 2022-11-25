//
//  LoginViewController.swift
//  interview-buddy
//
//  Created by Juan David Gutierrez Ochoa on 2022-11-16.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func loginTapped(_ sender: Any) {
        
        //Validate text fields
        let error = validateFields()
        
        if error != nil{
            showError(error)
        }else{
            
            //Signing in the user
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            
            
            
            
            
            Auth.auth().signIn(withEmail: email, password: password ){
                (result, error) in
                
                if error != nil {
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                }else{
                    self.transitionToHome()
                }
            }
        }
        
    }
    
    func transitionToHome(){
        
        let questionsViewController = storyboard?.instantiateViewController(identifier: Constans.Storyboard.questionsViewController) as? QuestionViewController
        
        view.window?.rootViewController = questionsViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    //nil if correct
    func validateFields() -> String?{
        
        //Check that fields are filled in
        if  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields."
        }
        
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
               
        if Utilities.isValidEmail(cleanedEmail) == false{
            return  "Not valid email format"
        }
          
        return nil
    }
    
    private func showError(_ error: String?) {
        errorLabel.text = error!
        errorLabel.alpha = 1
    }
    
}

