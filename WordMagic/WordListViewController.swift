//
//  WordListViewController.swift
//  WordMagic
//
//  Created by Rishabh Singh on 11/9/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//

import UIKit
import CoreData
import HoverConversion
class WordListViewController: HCRootViewController {
    var name = ""
    var words = [Word]();

    override func viewDidLoad() {
        super.viewDidLoad()
       // navigationController?.isNavigationBarHidden = false
        navigationView.backgroundColor = UIColor(red: 85 / 255, green: 172 / 255, blue: 238 / 255, alpha: 1)
        navigationView.titleLabel.textColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        title = name
       //self.deleteIncidents()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

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
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Word")
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

extension WordListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let word = words[(indexPath as NSIndexPath).row]
        //let level = levels[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        let rectangle = UIView(frame: CGRect(x: 5, y: 5, width: cell.frame.size.width + 45, height: 76))
        rectangle.alpha = 0.5
        rectangle.layer.borderColor = UIColor.black.cgColor
        rectangle.layer.borderWidth = 2.0
        rectangle.layer.cornerRadius = 10.0
        // Add the rectangle to your cell
        cell.addSubview(rectangle)

        if(words.count>0){
            //cell.wordValue = ((String)word, "1")
            cell.wordValue = (words[indexPath.row].spelling, String(words[indexPath.row].level))
            //print(words[indexPath.row].spelling!)
        }
        return cell
    }
}

extension WordListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HomeTableViewCell.Height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        showPagingViewContoller(indexPath: indexPath)
    }
}


extension WordListViewController: HCPagingViewControllerDataSource {
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


