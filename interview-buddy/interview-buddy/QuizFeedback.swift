//
//  ViewController.swift
//  interview-buddy
//
//  Created by Juan David Gutierrez Ochoa on 2022-10-18.
//

import UIKit

class QuizFeedback: UIViewController {

    @IBOutlet weak var rePlayButton: UIButton!
    
    @IBOutlet weak var homeButton: UIButton!
    
    @IBOutlet weak var topicsToReviewTV: UITextView!
    @IBOutlet weak var correctTV: UITextView!
    @IBOutlet weak var timedOutTV: UITextView!
    @IBOutlet weak var mistakesTV: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rePlayButton.layer.cornerRadius = 15
        rePlayButton.clipsToBounds = true
        
        homeButton.layer.cornerRadius = 15
        homeButton.clipsToBounds = true
        
        correctTV.layer.cornerRadius = 10
        mistakesTV.layer.cornerRadius = 10
        timedOutTV.layer.cornerRadius = 10
        topicsToReviewTV.layer.cornerRadius = 10

    }


}

