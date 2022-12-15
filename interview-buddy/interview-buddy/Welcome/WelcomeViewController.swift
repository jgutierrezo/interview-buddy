//
//  WelcomeViewController.swift
//  interview-buddy
//
//  Created by Rodrigo Chavez on 2022-12-05.
//

import UIKit
import FirebaseAuth

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Check if there is a user logged in
        if (Auth.auth().currentUser?.uid != nil) {
            transitionToHome()
        }
    }
    
    func transitionToHome(){
        // Set the navigationController in the tab view as the root screen
        let navigationControllerViewController = storyboard?.instantiateViewController(identifier: Constans.Storyboard.navigationControllerViewController) as? NavigationControllerViewController
        
        view.window?.rootViewController = navigationControllerViewController
        view.window?.makeKeyAndVisible()
        self.dismiss(animated: true, completion: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
