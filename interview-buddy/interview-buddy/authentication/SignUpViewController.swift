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
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    


    
    // This function validates that all fields have been filled in correctly.
    func validateFields() -> String?{
        
        //Check that fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields."
        }
        
        // Here we store the data from the text fields in a variable.
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Check if password is secure
        let securePassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Here we check that the email is in a valid format.
        if Utilities.isValidEmail(cleanedEmail) == false{
            return  "Not valid email format"
        }
            
        // Here we check if the password is secure.
        if Utilities.isPasswordValid(securePassword) == false{
            return  "Password must contain at least 8 characters, a special character, and a number"
        }
        
        // If all criteria are met, the function returns nil.
        return nil
    }


    // This function shows an error message if there is an issue with the user input.
    private func showError(_ error: String?) {
        errorLabel.text = error!
        errorLabel.alpha = 1
    }

    // This function transitions the user to the home screen.
    func transitionToHome(){
        
        // Here we instantiate the navigation view controller.
        let navigationControllerViewController = storyboard?.instantiateViewController(identifier: Constans.Storyboard.navigationControllerViewController) as? NavigationControllerViewController
        
        // Here we make the navigation view controller the current view controller.
        view.window?.rootViewController = navigationControllerViewController
        view.window?.makeKeyAndVisible()
        
    }

    // This function is called when the user taps the sign up button.
    @IBAction func signUpTapped(_ sender: Any) {
        // Here we validate the user input.
        let error = validateFields()
        if error != nil{
            showError(error)
        }else{
            // Here we store the cleaned versions of the data in a variable.
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Here we use firebase to create a new user.
            Auth.auth().createUser(withEmail: email, password: password){(result, err) in
                
                // Here we check for errors.
                if let err = err{
                    self.showError("Error creating user: "+err.localizedDescription)
                }else{
                    // Here we store the user's name and uid in the database.
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname": firstName, "lastname": lastName, "uid": result!.user.uid]){(error) in
                        if error != nil{
                            self.showError("Errors in user name and last name")
                        }
                    }
                    
                    // Here we innitialize the user in the badges collection
                    db.collection("quizesToBadges").addDocument(data: ["language": "JS", "left": 10, "level": "Beginner", "user": result!.user.uid]){(error) in
                        if error != nil{
                            self.showError("Errors in user name and last name")
                        }
                    }
                    
                    // Here we transition the user to the home screen.
                    self.transitionToHome()
                }
            }
        }
    }
    
    
    
}
