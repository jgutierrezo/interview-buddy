//
//  BadgesViewController2.swift
//  interview-buddy
//
//  Created by Juan David Gutierrez Ochoa on 2022-12-03.
//

import FirebaseAuth
import FirebaseFirestore
import UIKit

class BadgesViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate {

  let db = Firestore.firestore()

  var data: [[String: Any]] = []
  var selectedLevel = ""
  var selectedCategorie = ""
  @IBOutlet weak var tView: UITableView!

  override func viewWillAppear(_ animated: Bool) {
    //This statement will access the Firebase Firestore database and get the documents from the 'badges' collection, where the user_id is equal to the currently logged in user
    db.collection("badges")
      .whereField("user_id", isEqualTo: Auth.auth().currentUser!.uid)
      .getDocuments { (querySnapshot, err) in
        //If there is an error with the query, console log it
        if let err = err {
          print("Error getting documents: \(err)")
          //If there is no error, set the data array to empty and loop through each document in the query
        } else {
          self.data = []
          for doc in querySnapshot!.documents {
            //For each document, append it to the data array
            self.data.append(doc.data())
          }
          //Finally, reload the table view
          self.tView.reloadData()
        }
      }
  }

  //This function will appear when the view has been displayed
  override func viewDidAppear(_ animated: Bool) {
    //Set the navigation bar to visible
    navigationController?.isNavigationBarHidden = false

  }

  //This function will appear when the view has loaded
  override func viewDidLoad() {
    //Set the navigation bar to visible
    navigationController?.isNavigationBarHidden = false
    super.viewDidLoad()
  }

  //This function will determine the number of rows in the table view
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //Return the number of items in the data array
    return data.count
  }

  //This function will create a table view cell for each item in the data array
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //Create a cell with the 'BadgeCell' identifier
    let cell =
      tableView.dequeueReusableCell(withIdentifier: "BadgeCell", for: indexPath)
      as! BadgeTableViewCell2
    //Set the image, language, and level labels to the values from the data array
    cell.img.image = UIImage(named: self.data[indexPath.row]["image"] as! String)
    cell.language.text = self.data[indexPath.row]["language"] as! String
    cell.level.text = self.data[indexPath.row]["level"] as! String
    //Return the completed cell
    return cell
  }

  //This function will sign out the user when the button is pressed
  @IBAction func signOut(_ sender: Any) {
    //Create an instance of the firebase authentication
    let firebaseAuth = Auth.auth()
    //Attempt to sign out the user
    do {
      //If successful, transition to the login view controller
      try firebaseAuth.signOut()

      self.transitionToLogin()

    } catch let signOutError as NSError {
      //If unsuccessful, console log the error
      print("Error signing out: %@", signOutError)
    }
  }

  //This function will transition the user to the login view controller
  func transitionToLogin() {
    //Create an instance of the login view controller
    let loginViewController =
      storyboard?.instantiateViewController(identifier: Constans.Storyboard.authNavController)
      as? AuthNavController
    //Set the root view controller to the login view controller and make it visible
    view.window?.rootViewController = loginViewController
    view.window?.makeKeyAndVisible()

  }

}
