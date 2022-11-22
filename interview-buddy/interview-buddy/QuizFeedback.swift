//
//  ViewController.swift
//  interview-buddy
//
//  Created by Juan David Gutierrez Ochoa on 2022-10-18.
//

import UIKit
import FirebaseFirestore

class QuizFeedback: UIViewController {

    @IBOutlet weak var rePlayButton: UIButton!
    
    @IBOutlet weak var homeButton: UIButton!
    
    @IBOutlet weak var topicsToReviewTV: UITextView!
    @IBOutlet weak var correctTV: UITextView!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet weak var mistakesTV: UITextView!
    @IBOutlet var quizzesLeft: UITextView!
    
    var data:  Dictionary<String, Any>
    let db = Firestore.firestore()
    var user: String
    
    required init?(coder aDecoder: NSCoder) {
        self.data = [:]
        self.user = "j8Gzxm0KkAUBZabZIPteGgWkbKx2"
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        getQuizzesStatus()
        if (self.data["correct"]! as! Int > self.data["incorrect"]! as! Int) {
            statusLabel.text = "Passed!"
            statusLabel.textColor = UIColor.green
        } else {
            statusLabel.text = "Failed!"
            statusLabel.textColor = UIColor.red
        }
        correctTV.text = "Correct \n \(self.data["correct"]!)"
        mistakesTV.text = "Incorrect \n \(self.data["incorrect"]!)"
        var topicsString: String = "Topics to review: \n"
        for topic in self.data["topics"]! as! Set<String> {
            topicsString += " - \(topic) \n"
        }
        topicsToReviewTV.text = topicsString
    }
    
    func getQuizzesStatus() {
        db.collection("quizesToBadges")
            .whereField("language", isEqualTo: self.data["language"]!)
            .whereField("level", isEqualTo: self.data["level"]!)
            .whereField("user", isEqualTo: self.user)
            .getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let data = querySnapshot!.documents[0].data()
                let number: Int = data["left"] as! Int
                if number == 0 {
                    self.quizzesLeft.text = "Badge Achieved!"
                } else {
                    if (self.data["correct"]! as! Int > self.data["incorrect"]! as! Int) {
                        self.db.collection("quizesToBadges")
                            .document(querySnapshot!.documents[0].documentID)
                            .updateData([
                                "left": number - 1
                            ])
                        self.quizzesLeft.text = "Pending Quizes for badge: \(number - 1)"
                    } else {
                        self.quizzesLeft.text = "Pending Quizes for badge: \(number)"
                    }
                }
            }
        }

    }
    
    func setStyle() {
        rePlayButton.layer.cornerRadius = 15
        rePlayButton.clipsToBounds = true
        homeButton.layer.cornerRadius = 15
        homeButton.clipsToBounds = true
        
        correctTV.layer.cornerRadius = 10
        mistakesTV.layer.cornerRadius = 10
        topicsToReviewTV.layer.cornerRadius = 10
    }


}

