//
//  SignUpViewController.swift
//  interview-buddy
//
//  Created by Juan David Gutierrez Ochoa on 2022-11-16.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    
    //nil if correct
    func validateFields() -> String?{
        
        //Check that fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields."
        }
        
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        // Check if password is secure
        
        let securePassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isValidEmail(cleanedEmail) == false{
            return  "Not valid email format"
        }
            
        if Utilities.isPasswordValid(securePassword) == false{
            return  "Password must contain at least 8 characters, a special character, and a number"
        }
        
        return nil
    }
    

    private func showError(_ error: String?) {
        errorLabel.text = error!
        errorLabel.alpha = 1
    }
    
    func transitionToHome(){
        
        let categoriesViewController = storyboard?.instantiateViewController(identifier: Constans.Storyboard.categoriesViewController) as? LanguageViewController
        
        view.window?.rootViewController = categoriesViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil{
            showError(error)
        }else{
            
            //Cleaned versions of the data
            
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password){(result, err) in
                
                if let err = err{
                    self.showError("Error creating user")
                }else{
                    //User created, now store name
                    
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname": firstName, "lastname": lastName, "uid": result!.user.uid]){(error) in
                        if error != nil{
                            self.showError("Errors in user name and last name")
                        }
                    }
                    
                    db.collection("quizesToBadges").addDocument(data: ["language": "JS", "left": 10, "level": "Beginner", "user": result!.user.uid]){(error) in
                        if error != nil{
                            self.showError("Errors in user name and last name")
                        }
                    }
                    
                    
                    
                    self.transitionToHome()
                    
                }
                
            }
            
            
        }
        
    }
    
    
    
}
