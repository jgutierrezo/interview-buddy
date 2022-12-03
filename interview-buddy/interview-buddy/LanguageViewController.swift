//
//  LanguageViewController.swift
//  interview-buddy
//
//  Created by Rodrigo Chavez on 2022-12-01.
//

import UIKit
import FirebaseFirestore

class LanguageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let db = Firestore.firestore()
    @IBOutlet weak var cView: UICollectionView!
    var data: [Dictionary<String, Any>] = []
    var selected = ""
    
    override func viewWillAppear(_ animated: Bool) {
        db.collection("language").getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.data = []
                for doc in querySnapshot!.documents {
                    self.data.append(doc.data())
                }
                self.cView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cView.dequeueReusableCell(withReuseIdentifier: "language", for: indexPath) as! LanguageCollectionViewCell
        cell.label.text = self.data[indexPath.row]["language"] as! String
        cell.image.image = UIImage(named:self.data[indexPath.row]["image"] as! String)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selected = self.data[indexPath.row]["language"] as! String
        performSegue(withIdentifier: "LanguageToSubCategorie", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LanguageToSubCategorie" {
            if let nextViewController = segue.destination as? CategorieViewController{
                nextViewController.language = self.selected
            }
        }
    }

}
