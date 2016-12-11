
//
//  SetViewController.swift
//  WordMagic
//
//  Created by Rishabh Singh on 11/7/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//

import UIKit
import HoverConversion
import CoreData
var names = [Set]()
var wordList = [[]]
var setForPractice = -1

class SetViewController: HCRootViewController {
    var nameValue = "";
    
    var word = ["abs","abcd"]
    var selected: Int = 0
  
    
    @IBOutlet weak var setViewTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        navigationView.backgroundColor = UIColor(red: 85 / 255, green: 172 / 255, blue: 238 / 255, alpha: 1)
        navigationView.titleLabel.textColor = .white
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        //  tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        tableView.register(UITableViewCell.self,forCellReuseIdentifier: "setName")
        self.tableView.separatorColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1)
       
        //self.deleteIncidents()
        title = "Sets"
        //for i in 1 ..< 11 {
        //    let str = "Set \(i)"
        //    self.saveSet(name: str)
        //}
        
        
        if (!isAppAlreadyLaunchedOnce()) {
            self.addSet()
        } else {
            self.reloadData()
        }
        
        for i in 0...5{
            wordList.append([])
        }
        
        for set in names{
            print("VALUE")
            print(set.name)
            for words in set.words!{
                print((words as! Word).spelling)
                print((words as! Word).level)
                let levelValue:Int = Int((words as! Word).level)
                print(levelValue)
                wordList[levelValue].append(words)
                
            }
            
        }

        
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func isAppAlreadyLaunchedOnce() -> Bool{

        let defaults = UserDefaults.standard
        
        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched : \(isAppAlreadyLaunchedOnce)")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
    
    func addSet() {
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "http://192.241.144.178/wordmagic/")!
        
        
        let alertController = UIAlertController(title: "Wait", message: "Fetching words from the server. This happens only one time.", preferredStyle: UIAlertControllerStyle.alert)
        self.present(alertController, animated: true, completion: nil)
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                
                //print("F apple: " + error!.localizedDescription)
                alertController.dismiss(animated: true, completion: nil)
                
                
                let alertController = UIAlertController(title: "Error: Cannot connect to internet", message: "This app needs internet connection to load words on the first run.", preferredStyle: UIAlertControllerStyle.alert)
                let cancelAction = UIAlertAction(title: "Okay", style: .default) { (action: UIAlertAction) -> Void in
                }
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)

                
            } else {
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        //print(json)
                        if let sets = json["sets"] as? [[String: Any]] {
                            for set in sets {
                                self.saveSet(name: set["name"] as! String, words: set["words"] as! [[String: Any]])
                            }
                            self.reloadData()
                            alertController.dismiss(animated: true, completion: nil)
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
    
    func deleteIncidents() {
        return
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Set")
        request.returnsObjectsAsFaults = false
        
        do {
            let incidents = try context.fetch(request)
            
            if incidents.count > 0 {
                
                for result in incidents{
                    context.delete(result as! NSManagedObject)
                    print("NSManagedObject has been Deleted")
                }
                try context.save() } } catch {}
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("HERE..")
        
        if (segue.identifier == "showWordList") {
            let todetail:WordListViewController = segue.destination as! WordListViewController
            
            todetail.name = nameValue
            todetail.words = []
            for w in names[selected].words! {
                todetail.words.append(w as! Word)
            }
        }
        
        if (segue.identifier == "practiceSession") {
            let controller:PraticeViewController = segue.destination as! PraticeViewController
            controller.spacedAlgo = SpacedRepetitionAlgo(sel: AllWordSelector())
        }
        

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func saveSet(name: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        if let set = NSEntityDescription.insertNewObject(forEntityName: "Set", into: context) as? Set {
            set.name = name
            do {
                try context.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
    
    func reloadData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        print("abc: start")
        let setsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Set")
        do {
            names = try context.fetch(setsFetch) as! [Set]
            print("abc: end")
            self.tableView.reloadData()
            print("abc: end2")
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
}

extension SetViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let setName = names[(indexPath as NSIndexPath).row]
        print(setName)
        //   let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "setName") as! UITableViewCell
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "setName")! as UITableViewCell;
                 let button : UIButton = UIButton(type:UIButtonType.custom) as UIButton
         
         button.frame = CGRect(origin: CGPoint(x: 40,y :20), size: CGSize(width: 100, height: 20))
         let cellHeight: CGFloat = 80.0
         button.center = CGPoint(x: view.bounds.width/2 , y: cellHeight/1.2)
         button.backgroundColor = UIColor.gray
         button.addTarget(self, action: #selector(buttonClicked), for: UIControlEvents.touchUpInside)
        button.tag = indexPath.row
         button.setTitle("Practice", for: UIControlState.normal)
         
        
        let rectangle = UIView(frame: CGRect(x: 5, y: 5, width: cell.frame.size.width + 45, height: 76))
        rectangle.alpha = 0.8
        rectangle.layer.borderColor = UIColor.darkGray.cgColor
        rectangle.layer.borderWidth = 2.0
        rectangle.layer.cornerRadius = 10.0
           // Add the rectangle to your cell
        cell.addSubview(rectangle)
       
        cell.addSubview(button)
        
        
        
        if(names.count>0){
            cell.textLabel!.text = names[indexPath.row].name
        }
       
        return cell
        
    }
    func buttonClicked(sender: UIButton){
     print("ia ma cliscke")
    setForPractice = sender.tag + 1
     performSegue(withIdentifier: "practiceSession", sender: self)

    }
}
extension SetViewController: UITableViewDelegate {
    /* func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     return HomeTableViewCell.Height
     }*/
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did Select Called")
        tableView.deselectRow(at: indexPath, animated: false)
        let cell = tableView.cellForRow(at: indexPath)
        nameValue = cell!.textLabel!.text!
        print("tect" , nameValue)
        selected = indexPath.row
        performSegue(withIdentifier: "showWordList", sender: self)
        
    }
    func tableView(_ tableView: UITableView, editActionsForRowAtIndexPath indexPath: IndexPath) -> [AnyObject]? {
        
        let practice = UITableViewRowAction(style: .normal, title: "Practice") { action, index in
            print("practice")
            
        }
        practice.backgroundColor = UIColor.blue
        
        let report = UITableViewRowAction(style: .normal, title: "Report") { action, index in
            print("report")
            let alert = UIAlertController(title: "Lets report something",
                                          message: "report",
                                          preferredStyle: .alert)
            
            
            let cancelAction = UIAlertAction(title: "Cancel",
                                             style: .default) { (action: UIAlertAction) -> Void in
            }
            
            alert.addTextField {
                (textField: UITextField) -> Void in
            }
            
            alert.addAction(cancelAction)
            
            self.present(alert,animated: true,completion: nil)
            
        }
        report.backgroundColor = UIColor.orange
        
        return [practice, report]
    }
    
    
}



