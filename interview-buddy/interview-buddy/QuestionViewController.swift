//
//  QuestionViewController.swift
//  interview-buddy
//
//  Created by Rodrigo Chavez on 2022-11-08.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answer1: UIButton!
    @IBOutlet var answer2: UIButton!
    @IBOutlet var answer3: UIButton!
    @IBOutlet var answer4: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = "Que lenguaje se usa para IOS"
        answer1.setTitle("Swift", for: .normal)
        answer2.setTitle("Python", for: .normal)
        answer3.setTitle("Java", for: .normal)
        answer4.setTitle("C++", for: .normal)
    }
    
    @IBAction func selectAnswer(_ sender: UIButton){
        print(sender.titleLabel!.text)
    }

}
