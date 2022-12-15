//
//  LoginViewController.swift
//  interview-buddy
//
//  Created by Juan David Gutierrez Ochoa on 2022-11-16.
//

import FirebaseAuth
import UIKit

class LoginViewController: UIViewController {

  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!

  @IBOutlet weak var errorLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }

  override func viewDidAppear(_ animated: Bool) {
    navigationController?.isNavigationBarHidden = false
  }

  //This function is connected to the login button. It will validate the fields, and if all fields are filled out correctly will sign in the user.
  @IBAction func loginTapped(_ sender: Any) {

    //Validate text fields. Checks that the fields have been filled out
    let error = validateFields()

    //If an error message is returned, show the error
    if error != nil {
      showError(error)
    } else {

      //Signing in the user. Gets the email and password from the text fields and attempts to sign in the user
      let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

      Auth.auth().signIn(withEmail: email, password: password) {
        (result, error) in

        //Checks for an error, and if there is an error, shows the error
        if error != nil {
          self.errorLabel.text = error!.localizedDescription
          self.errorLabel.alpha = 1
        } else {
          //If no error, transition to the home controller
          self.transitionToHome()
        }
      }
    }

  }

  //This function will transition the user to the home screen
  func transitionToHome() {

    //Instantiate the navigation controller view controller and sets it as the root view controller
    let navigationControllerViewController =
      storyboard?.instantiateViewController(
        identifier: Constans.Storyboard.navigationControllerViewController)
      as? NavigationControllerViewController

    view.window?.rootViewController = navigationControllerViewController
    view.window?.makeKeyAndVisible()

  }

  //Validates the fields. Checks that the email is in valid format and that both fields have been filled out
  //nil if correct
  func validateFields() -> String? {

    //Check that fields are filled in
    if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
      || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    {
      return "Please fill in all fields."
    }

    let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

    //Checks if the email is in valid format
    if Utilities.isValidEmail(cleanedEmail) == false {
      return "Not valid email format"
    }

    return nil
  }

  //Shows the error to the user
  private func showError(_ error: String?) {
    errorLabel.text = error!
    errorLabel.alpha = 1
  }

}
