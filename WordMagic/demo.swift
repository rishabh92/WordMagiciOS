/*
//  SetViewController.swift
//  WordMagic
//
//  Created by Rishabh Singh on 11/7/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//

import UIKit
import HoverConversion
import CoreData

class SetViewController: HCRootViewController {
    var nameValue = "";
    var names = [Set]()
    
    
    @IBOutlet weak var setViewTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        navigationView.backgroundColor = UIColor(red: 85 / 255, green: 172 / 255, blue: 238 / 255, alpha: 1)
        navigationView.titleLabel.textColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        //  tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        tableView.register(UITableViewCell.self,forCellReuseIdentifier: "setName")
        self.deleteIncidents()
        title = "Sets"
        for i in 1 ..< 11 {
            let str = "Set \(i)"
            self.saveSet(name: str)
        }
        self.tableView.reloadData()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func deleteIncidents() {
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
                reloadData()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
    
    func reloadData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let setsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Set")
        do {
            self.names = try context.fetch(setsFetch) as! [Set]
            self.tableView.reloadData()
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
        if(names.count>0){
            cell.textLabel!.text = names[indexPath.row].name
        }
        return cell
        
    }
}
extension SetViewController: UITableViewDelegate {
    /* func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     return HomeTableViewCell.Height
     }*/
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did Select Called")
        let cell = tableView.cellForRow(at: indexPath)
        nameValue = cell!.textLabel!.text!
        print("tect" , nameValue)
        performSegue(withIdentifier: "showWordList", sender: self)
        
    }
    func tableView(_ tableView: UITableView, editActionsForRowAtIndexPath indexPath: IndexPath) -> [AnyObject]? {
        print("HERE")
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
 */
