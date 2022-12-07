//
//  LanguageViewController.swift
//  interview-buddy
//
//  Created by Rodrigo Chavez on 2022-12-01.
//

import UIKit
import FirebaseAuth
import CoreData

class LanguageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var cView: UICollectionView!
    var data: [NSManagedObject] = []
    var selected = ""
    
    //reference to core data storage
    var managedContext: NSManagedObjectContext!
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
        insertData()
        let request: NSFetchRequest<Language> = Language.fetchRequest()
        do {
            self.data = try managedContext.fetch(request)
        }  catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func insertData() {
        /*
         This function will insert the sample plist data into CoreData
         */
        
        //perform a fetch
        let fetch: NSFetchRequest<Language> = Language.fetchRequest()
        
        //perform a search inside the BowTie entity
        fetch.predicate = NSPredicate(format: "searchKey != nil")
        
        //count all data the stored in storage
        let count = (try? managedContext.count(for: fetch)) ?? 0
    
        //if there are entities with searchKey's, return
        if count > 0 {
            return //this means we already loaded sample data
        }
        
        //retrieve plist of sample data
        let path = Bundle.main.path(forResource: "LanguagesData", ofType: "plist")
        
        //set contents of plist to dataArray
        let dataArray = NSArray(contentsOfFile: path!)!
        
        //for the dictionary in the array
        for dict in dataArray {
            //entity is BowTie2
            let entity = NSEntityDescription.entity(forEntityName: "Languages", in: managedContext)!
            
            //input bow tie entity into storage
            let language = Language(entity: entity, insertInto: managedContext)
            
            //plist data
            let dataDict = dict as! [String: Any]
            
            //set bowtie entity to plist data
            language.language = dataDict["language"] as? String
            language.searchKey = dataDict["searchKey"] as? String
            language.imageName = dataDict["image"] as? String
            
            let imageName = dataDict["image"] as? String
            let image = UIImage(named: imageName!)
            language.image = image?.jpegData(compressionQuality: 8.0) //setting the image
            
        }
        //save bow tie data to core data
        try! managedContext.save()
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cView.dequeueReusableCell(withReuseIdentifier: "language", for: indexPath) as! LanguageCollectionViewCell
        let language = self.data[indexPath.row]
        let image = language.value(forKey: "image") as! Data
        cell.label.text = language.value(forKey: "language") as? String
        cell.image.image = UIImage(data: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let language = self.data[indexPath.row]
        self.selected = language.value(forKey: "language") as! String
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
