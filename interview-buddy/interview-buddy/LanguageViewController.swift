//
//  LanguageViewController.swift
//  interview-buddy
//
//  Created by Rodrigo Chavez on 2022-12-01.
//

import UIKit

class LanguageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var cView: UICollectionView!
    var data = [
        ["language": "Java", "image": "image2"],
        ["language": "Swift", "image": "image3"],
        ["language": "JavaScript", "image": "image1"],
    ]
    var selected = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cView.dequeueReusableCell(withReuseIdentifier: "language", for: indexPath) as! LanguageCollectionViewCell
        cell.label.text = self.data[indexPath.row]["language"]
        cell.image.image = UIImage(named:self.data[indexPath.row]["image"]!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selected = self.data[indexPath.row]["language"]!
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
