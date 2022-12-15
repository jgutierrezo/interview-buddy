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
        self.user = userFirestore!.uid
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getQuizzesStatus()
        let c = self.data["correct"] as! Int
        let i = self.data["incorrect"] as! Int
        // Calculate percentage
        var result: Int = 100
        if (i != 0) {
            result = c * 100 / (i + c)
        }
        // Render screen depending on the grade
        if (self.data["correct"] as! Int >= self.data["incorrect"] as! Int) {
            status.text = "Congratulations!"
            status.textColor = UIColor(red: 0.53, green: 0.87, blue: 0.53, alpha: 1.00)
            score.text = "You have passed the quiz with \(result)%"
        } else {
            status.text = "Try Again!"
            status.textColor = UIColor.red
            score.text = "You have failed the quiz with \(result)%"
        }
        correctTV.text = "Correct \(self.data["correct"]!)"
        mistakesTV.text = "Mistake \(self.data["incorrect"]!)"
        // Create the topics String depending on the data recieved
        var topicsString: String = "Topics to review: \n"
        for topic in self.data["topics"]! as! Set<String> {
            topicsString += " - \(topic) \n"
        }
        topicsToReviewTV.text = topicsString
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Hide the back button
        navigationController?.isNavigationBarHidden = true
    }
    
    func getQuizzesStatus() {
        // fetch the number of quizzes left for a batch from firestore
        db.collection("quizesToBadges")
            .whereField("language", isEqualTo: self.data["language"]!)
            .whereField("level", isEqualTo: self.data["level"]!)
            .whereField("user", isEqualTo: self.user)
            .getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if (querySnapshot!.documents.count <= 0) {
                    // if there is no document for this level, language and user it will create it
                    var num = 10
                    if (self.data["correct"]! as! Int >= self.data["incorrect"]! as! Int) {
                            num = 9
                    }
                    self.quizzesLeft.text = "Pending Quizes for badge: \(num)"
                    self.db.collection("quizesToBadges").addDocument(data: ["language": self.data["language"], "left": num, "level": self.data["level"], "user": self.user]){(error) in
                        if error != nil{
                            print("Error")
                        }
                    }
                } else {
                    let data = querySnapshot!.documents[0].data()
                    let number: Int = data["left"] as! Int
                    if number == 0 {
                        // Badge was already achieved
                        self.quizzesLeft.text = "Badge Achieved!"
                    } else {
                        // Validates if the quizzed was passed
                        if (self.data["correct"]! as! Int >= self.data["incorrect"]! as! Int) {
                            if (number == 1) {
                                // When badge is achieved it will create the document in collection badge
                                self.db.collection("badges").addDocument(data: ["language": self.data["language"], "image": "badge2", "level": self.data["level"], "user_id": self.user]){(error) in
                                    if error != nil{
                                        print("Error")
                                    }
                                }
                                self.quizzesLeft.text = "Badge Achieved!"
                            }
                            else {
                                self.quizzesLeft.text = "Pending Quizes for badge: \(number - 1)"
                            }
                            // Update the quizzes left for a badge
                            self.db.collection("quizesToBadges")
                                .document(querySnapshot!.documents[0].documentID)
                                .updateData([
                                    "left": number - 1
                                ])
                        } else {
                            self.quizzesLeft.text = "Pending Quizes for badge: \(number)"
                        }
                    }
                    
                }
            }
        }

    }
    


    @IBAction func signOut(_ sender: Any) {
        // sign out current user
        let firebaseAuth = Auth.auth()
    do {
        
      try firebaseAuth.signOut()
        
        self.transitionToLogin()
        
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
    }
    
    func transitionToLogin(){
        // go to Welcome screen
        let loginViewController = storyboard?.instantiateViewController(identifier: Constans.Storyboard.loginViewController) as? LoginViewController
        
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Passed the data for results screen
        if segue.identifier == "FeedbackToReview" {
            if let nextViewController = segue.destination as? QuizResultsViewController {
                nextViewController.correct = self.data["correct"] as! Int
                nextViewController.mistakes = self.data["incorrect"] as! Int
                nextViewController.data = self.data["results"] as! [Bool]
            }
        }
    }
    
}

