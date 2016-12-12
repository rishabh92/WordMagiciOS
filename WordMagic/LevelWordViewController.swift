//
//  LevelWordViewController.swift
//  WordMagic
//
//  Created by Rishabh Singh on 11/27/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//

import UIKit
import CoreData
import HoverConversion
class LevelWordViewController: HCRootViewController {

    var name = ""
    var words = [Word]();
    //var words = ["word1", "word2", "word3", "word4", "word5", "word6","word7", "word8", "word9", "word10","word11", "word12"]
    // var levels = ["1", "2", "3", "1", "5", "3","2", "4","5", "3","2", "4"]
    var wordList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationView.backgroundColor = UIColor(red: 85 / 255, green: 172 / 255, blue: 238 / 255, alpha: 1)
        navigationView.titleLabel.textColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        title = name
        // self.deleteIncidents()
        //for i in 0 ..< wordList.count {
         //   self.saveWord(name: wordList[i])
        //}
        self.tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    fileprivate func showPagingViewContoller(indexPath: IndexPath) {
        let vc = HCPagingViewController(indexPath: indexPath)
        vc.dataSource = self
        navigationController?.pushViewController(vc, animated: true)
    }
    func saveWord(name: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        if let word = NSEntityDescription.insertNewObject(forEntityName: "Word", into: context) as? Word {
            word.spelling = name
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
        let setsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Word")
        do {
            self.words = try context.fetch(setsFetch) as! [Word]
            self.tableView.reloadData()
        } catch {
            fatalError("Failed to fetch : \(error)")
        }
    }
    func deleteIncidents() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Words")
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

}
extension LevelWordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        if(words.count>0){
            cell.wordValue = (words[indexPath.row].spelling, String(words[indexPath.row].level))
        }
        return cell
    }
}

extension LevelWordViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HomeTableViewCell.Height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        showPagingViewContoller(indexPath: indexPath)
    }
}


extension LevelWordViewController: HCPagingViewControllerDataSource {
    func pagingViewController(_ viewController: HCPagingViewController, viewControllerFor indexPath: IndexPath) -> HCContentViewController? {
        guard 0 <= indexPath.row && indexPath.row < words.count else { return nil }
        let vc = WordViewController()
        vc.word = words[indexPath.row]
        return vc
    }
    
    func pagingViewController(_ viewController: HCPagingViewController, nextHeaderViewFor indexPath: IndexPath) -> HCNextHeaderView? {
        guard 0 <= indexPath.row && indexPath.row < words.count else { return nil }
        let view = NextHeaderView()
        view.word = words[indexPath.row].spelling
        return view
        
    }
}
