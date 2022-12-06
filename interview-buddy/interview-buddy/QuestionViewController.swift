//
//  QuestionViewController.swift
//  interview-buddy
//
//  Created by Rodrigo Chavez on 2022-11-08.
//
import UIKit
import FirebaseFirestore
import FirebaseAuth

class QuestionViewController: UIViewController {
    
    let db = Firestore.firestore()

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answer1: UIButton!
    @IBOutlet var answer2: UIButton!
    @IBOutlet var answer3: UIButton!
    @IBOutlet var answer4: UIButton!
    @IBOutlet var questionTitle: UILabel!
    
    var language: String
    var level: String
    var categorie: String
    
    var data: Dictionary<String, Any>
    var questionNumber: Int
    var correct: Int
    var incorrect : Int
    var topicsToReview: Set<String>
    var questions: [Dictionary<String, Any>]
    var results: [Bool]
    
    required init?(coder aDecoder: NSCoder) {
        self.questionNumber = 0
        self.correct = 0
        self.incorrect = 0
        self.topicsToReview = []
        self.data = [:]
        self.questions = []
        self.language = ""
        self.level = ""
        self.categorie = ""
        self.results = []
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        db.collection("questions")
            .whereField("language", isEqualTo: self.language)
            .whereField("level", isEqualTo: level)
            .whereField("categorie", isEqualTo: categorie)
            .getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var index = 0
                if querySnapshot!.documents.count > 0 {
                    index = Int.random(in: 0..<querySnapshot!.documents.count )
                }
                let document = querySnapshot!.documents[index]
                self.data = document.data()
                self.questions = self.data["questions"] as! [Dictionary<String, Any>]
                self.setQuestion()
                
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        let loginViewController = storyboard?.instantiateViewController(identifier: Constans.Storyboard.authNavController) as? AuthNavController
        
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    func setQuestion() {
        questionTitle.text = "Question \(questionNumber + 1)"
        questionLabel.text = questions[questionNumber]["question"] as? String
        answer1.setTitle(questions[questionNumber]["answer1"] as? String, for: .normal)
        answer2.setTitle(questions[questionNumber]["answer2"] as? String, for: .normal)
        answer3.setTitle(questions[questionNumber]["answer3"] as? String, for: .normal)
        answer4.setTitle(questions[questionNumber]["answer4"] as? String, for: .normal)
    }
    
    @IBAction func selectAnswer(_ sender: UIButton){
        if questions[questionNumber]["correct"] as? String == sender.titleLabel!.text {
            correct += 1
            results.append(true)
        } else {
            incorrect +=  1
            results.append(false)
            self.topicsToReview.insert(questions[questionNumber]["topic"] as! String)
        }
        questionNumber += 1
        if questionNumber >= questions.count {
            performSegue(withIdentifier: "QuizDone", sender: nil)
        } else {
            setQuestion()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "QuizDone" {
            if let nextViewController = segue.destination as? QuizFeedback{
                var results: Dictionary<String, Any> = [:]
                results["correct"] = self.correct
                results["incorrect"] = self.incorrect
                results["topics"] = self.topicsToReview
                results["language"] = self.language
                results["level"] = self.level
                results["categorie"] = self.categorie
                results["results"] = self.results
                nextViewController.data = results
            }
        }
    }
}
