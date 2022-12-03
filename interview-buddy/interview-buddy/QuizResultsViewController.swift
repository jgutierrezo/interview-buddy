//
//  QuizResultsViewController.swift
//  interview-buddy
//
//  Created by Rodrigo Chavez on 2022-12-02.
//

import UIKit

class QuizResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet var status: UILabel!
    var data : [Bool] = [true, false, false, true]
    var correct: Int = 2
    var mistakes: Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        status.text = "Result \(self.correct)/\(self.correct + self.mistakes)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionResult", for: indexPath) as! QuestionResultTableViewCell
        cell.question.text = "Question \(indexPath.row + 1)"
        if (data[indexPath.row]) {
            cell.question.textColor = UIColor(red: 0.53, green: 0.87, blue: 0.53, alpha: 1.00)
            cell.img.image = UIImage(named:"checkSvgrepoCom2")
        } else {
            cell.question.textColor = UIColor.red
            cell.img.image = UIImage(named:"xSvgrepoCom1")
        }
        return cell
    }


}
