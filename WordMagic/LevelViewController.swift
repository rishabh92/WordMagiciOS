//
//  LevelViewController.swift
//  WordMagic
//
//  Created by Rishabh Singh on 11/21/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//

import UIKit
import HoverConversion
import CoreData


class LevelViewController: HCRootViewController {
     var nameValue = "";
    var names1 = ["Level 0","Level 1", "Level 2", "Level 3", "Level 4", "Level 5"]
    
    var selected: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
      //  var setViewController: SetViewController = SetViewController(nibName: nil, bundle: nil)
      //  var setNames = setViewController.names
        
        // Do any additional setup after loading the view.
        navigationView.backgroundColor = UIColor(red: 85 / 255, green: 172 / 255, blue: 238 / 255, alpha: 1)
        navigationView.titleLabel.textColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        //  tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
 //       tableView.register(UITableViewCell.self,forCellReuseIdentifier: "setName")
        self.tableView.separatorColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1)
        title = "Levels"
                print("WRD LIST 0  COUT")
        print(wordList[0].count)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("HERE..")
        
        if (segue.identifier == "levelWordList") {
            let todetail:LevelWordViewController = segue.destination as! LevelWordViewController
            
            todetail.name = nameValue
            todetail.words = []
            if(selected<wordList.endIndex){
                for w in wordList[selected] {
                    todetail.words.append(w as! Word)
                }
            }
            print(selected)
            print(wordList[0].count)
        }
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LevelViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let setName = names1[(indexPath as NSIndexPath).row]
        print(setName)
        //   let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "setName") as! UITableViewCell
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")! as UITableViewCell;
        let button : UIButton = UIButton(type:UIButtonType.custom) as UIButton
        
        button.frame = CGRect(origin: CGPoint(x: 40,y :20), size: CGSize(width: 100, height: 20))
        let cellHeight: CGFloat = 80.0
        button.center = CGPoint(x: view.bounds.width/2 , y: cellHeight/1.2)
        button.backgroundColor = UIColor.gray
        button.addTarget(self, action: #selector(buttonClicked), for: UIControlEvents.touchUpInside)
        button.tag = indexPath.row
        button.setTitle("Practice", for: UIControlState.normal)
        
        
        let rectangle = UIView(frame: CGRect(x: 5, y: 5, width: cell.frame.size.width + 45, height: 76))
        rectangle.alpha = 0.5
        rectangle.layer.borderColor = UIColor.black.cgColor
        rectangle.layer.borderWidth = 2.0
        rectangle.layer.cornerRadius = 10.0
        // Add the rectangle to your cell
        cell.addSubview(rectangle)
        
        cell.addSubview(button)
        if(names1.count>0){
            cell.textLabel!.text = names1[indexPath.row]
        }
        
        return cell
        
    }
    func buttonClicked(){
        print("ia ma cliscke")
        performSegue(withIdentifier: "practiceSession1", sender: self)
        
    }
}
extension LevelViewController: UITableViewDelegate {
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
        performSegue(withIdentifier: "levelWordList", sender: self)
        
    }
    
}




