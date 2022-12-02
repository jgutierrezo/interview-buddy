//
//  CategorieViewController.swift
//  interview-buddy
//
//  Created by Rodrigo Chavez on 2022-12-01.
//

import UIKit
import FirebaseFirestore

class CategorieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let db = Firestore.firestore()
    var language = ""
    var data: [Dictionary<String, Any>] = []
    var selected = ""
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

    override func viewDidLoad() {
        super.viewDidLoad()
        print(language)
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
        self.selected = self.data[indexPath.row]["level"] as! String
        performSegue(withIdentifier: "CategorieToQuestion", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CategorieToQuestion" {
            if let nextViewController = segue.destination as? QuestionViewController {
                nextViewController.language = self.language
                nextViewController.level = self.selected
            }
        }
    }

}
