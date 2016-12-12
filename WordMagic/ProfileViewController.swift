//
//  ProfileViewController.swift
//  WordMagic
//
//  Created by Haider Hameed on 12/11/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 85 / 255, green: 172 / 255, blue: 238 / 255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.title = "Profile"
        let attrs = [
            NSForegroundColorAttributeName: UIColor.white,
            //  NSFontAttributeName: UIFont(name: "Georgia-Bold", size: 24)!
        ]
        navigationController?.navigationBar.titleTextAttributes = attrs
    }
    @IBAction func onSyncAction(_ sender: UIButton) {
        addSet()
    }
    
    func addSet() {
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "http://192.241.144.178/wordmagic/")!
        
        
        let alertController = UIAlertController(title: "Wait", message: "Fetching words from the server.", preferredStyle: UIAlertControllerStyle.alert)
        self.present(alertController, animated: true, completion: nil)
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                
                print("F apple: " + error!.localizedDescription)
                alertController.dismiss(animated: true, completion: {
                    let alertController = UIAlertController(title: "Error: Cannot connect to internet", message: "Please check your internet connection and try again.", preferredStyle: UIAlertControllerStyle.alert)
                    let cancelAction = UIAlertAction(title: "Okay", style: .default) { (action: UIAlertAction) -> Void in
                    }
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                })
                
                

                
                
            } else {
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        //print(json)
                        if let sets = json["sets"] as? [[String: Any]] {
                            var new_sets = 0
                            for set in sets {
                                let set_id: Int = Int(set["id"] as! String)!
                                if set_id > names.count {
                                    self.saveSet(name: set["name"] as! String, words: set["words"] as! [[String: Any]])
                                    new_sets += 1
                                }
                            }
                            alertController.dismiss(animated: true, completion: {
                                let alertController = UIAlertController(title: "Sync Complete", message: "\(new_sets) new set(s) added.", preferredStyle: UIAlertControllerStyle.alert)
                                let cancelAction = UIAlertAction(title: "Okay", style: .default) { (action: UIAlertAction) -> Void in
                                }
                                alertController.addAction(cancelAction)
                                self.present(alertController, animated: true, completion: nil)
                            })
                        }
                        //Implement your logic
                        //print(json)
                    }
                } catch {
                    print("error in JSONSerialization")
                }
            }
        })
        task.resume()
    }
    
    func saveSet(name: String, words: [[String: Any]]) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        if let set = NSEntityDescription.insertNewObject(forEntityName: "Set", into: context) as? Set {
            set.name = name
            for word in words {
                if let w = NSEntityDescription.insertNewObject(forEntityName: "Word", into: context) as? Word {
                    w.spelling = (word["spelling"] as! String)
                    w.meaning = (word["definition"] as! String)
                    for sentence in word["sentences"] as! [[String: Any]] {
                        if let s = NSEntityDescription.insertNewObject(forEntityName: "Sentence", into: context) as? Sentence {
                            s.statement = (sentence["statement"] as! String)
                            w.addToSentences(s)
                        }
                    }
                    set.addToWords(w)
                }
            }
            do {
                try context.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
}
