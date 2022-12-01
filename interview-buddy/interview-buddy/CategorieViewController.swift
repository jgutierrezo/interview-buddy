//
//  CategorieViewController.swift
//  interview-buddy
//
//  Created by Rodrigo Chavez on 2022-12-01.
//

import UIKit

class CategorieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var language = ""
    var data = [
        ["name": "Cat1", "level": "Begginer"],
        ["name": "Cat2", "level": "Intermediate"],
        ["name": "Cat3", "level": "Advance"],
    ]
    var selected = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        print(language)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Categorie", for: indexPath) as! CategorieTableViewCell
        cell.name.text = self.data[indexPath.row]["name"]
        cell.level.text = self.data[indexPath.row]["level"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selected = self.data[indexPath.row]["name"]!
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
