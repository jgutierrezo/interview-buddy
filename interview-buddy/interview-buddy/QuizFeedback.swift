//
//  ViewController.swift
//  interview-buddy
//
//  Created by Juan David Gutierrez Ochoa on 2022-10-18.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class QuizFeedback: UIViewController {
    
    @IBOutlet weak var topicsToReviewTV: UITextView!
    @IBOutlet weak var correctTV: UILabel!
    @IBOutlet weak var mistakesTV: UILabel!
    @IBOutlet var quizzesLeft: UITextView!
    @IBOutlet var status: UILabel!
    @IBOutlet var score: UILabel!
    
    var data:  Dictionary<String, Any>
    let db = Firestore.firestore()
    var user: String
    
    //Obtain user
    let userFirestore = Auth.auth().currentUser
    
    
    required init?(coder aDecoder: NSCoder) {
        self.data = [:]
        //self.user = userFirestore!.uid
        self.user = "j8Gzxm0KkAUBZabZIPteGgWkbKx2"
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.data)
        getQuizzesStatus()
        let c = self.data["correct"] as! Int
        let i = self.data["incorrect"] as! Int
        var result: Int = 100
        if (i != 0) {
            result = c * 100 / (i + c) as! Int
        }
        if (self.data["correct"] as! Int >= self.data["incorrect"] as! Int) {
            status.text = "Congratulations!"
            score.text = "You have passed the quiz with \(result)%"
        } else {
            status.text = "Try Again!"
            score.text = "You have failed the quiz with \(result)%"
        }
        correctTV.text = "Correct \(self.data["correct"]!)"
        mistakesTV.text = "Mistake \(self.data["incorrect"]!)"
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
                    if (self.data["correct"]! as! Int >= self.data["incorrect"]! as! Int) {
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

