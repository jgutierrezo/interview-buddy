//
//  CategorieViewController.swift
//  interview-buddy
//
//  Created by Rodrigo Chavez on 2022-12-01.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
class CategorieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let db = Firestore.firestore()
    //var language = ""
    var language = ""
    var data: [Dictionary<String, Any>] = []
    var selectedLevel = ""
    var selectedCategorie = ""
    @IBOutlet weak var tView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        db.collection("categories")
            .whereField("language", isEqualTo: self.language)
            .getDocuments{(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.data = []
                for doc in querySnapshot!.documents {
                    self.data.append(doc.data())
                }
                self.tView.reloadData()
            }
        }
    }
    
    
    @IBAction func signOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
    do {
        
      try firebaseAuth.signOut()
        
        self.transitionToLogin()
        
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
    }
    
    func transitionToLogin(){
        
        let loginViewController = storyboard?.instantiateViewController(identifier: Constans.Storyboard.loginViewController) as? LoginViewController
        
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        
    }

    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = false
        super.viewDidLoad()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Categorie", for: indexPath) as! CategorieTableViewCell
        cell.name.text = self.data[indexPath.row]["name"] as! String
        cell.level.text = self.data[indexPath.row]["level"] as! String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedLevel = self.data[indexPath.row]["level"] as! String
        self.selectedCategorie = self.data[indexPath.row]["name"] as! String
        performSegue(withIdentifier: "CategorieToQuestion", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CategorieToQuestion" {
            if let nextViewController = segue.destination as? QuestionViewController {
                nextViewController.language = self.language
                nextViewController.categorie = self.selectedCategorie
                nextViewController.level = self.selectedLevel
            }
        }
    }

}
