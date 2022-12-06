//
//  BadgesViewController2.swift
//  interview-buddy
//
//  Created by Juan David Gutierrez Ochoa on 2022-12-03.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class BadgesViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let db = Firestore.firestore()
    
    var data: [Dictionary<String, Any>] = []
    var selectedLevel = ""
    var selectedCategorie = ""
    @IBOutlet weak var tView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        db.collection("badges")
            .whereField("user_id", isEqualTo: Auth.auth().currentUser!.uid)
            .getDocuments{(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                print("entro")
                self.data = []
                for doc in querySnapshot!.documents {
                    print("loop")
                    self.data.append(doc.data())
                }
                self.tView.reloadData()
            }
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "BadgeCell", for: indexPath) as! BadgeTableViewCell2
       // cell.name.text = self.data[indexPath.row]["image"] as! String
        cell.img.image = UIImage(named:self.data[indexPath.row]["image"] as! String)
        cell.language.text = self.data[indexPath.row]["language"] as! String
        cell.level.text = self.data[indexPath.row]["level"] as! String
        return cell
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


}
