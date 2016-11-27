//
//  WordViewController.swift
//  WordMagic
//
//  Created by Rishabh Singh on 11/9/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//

import UIKit
import HoverConversion

class WordViewController: HCContentViewController {
    var word: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationView.backgroundColor = UIColor(red: 85 / 255, green: 172 / 255, blue: 238 / 255, alpha: 1)
        
        if let word = word {
            navigationView.titleLabel.numberOfLines = 1
            let attributedText = NSMutableAttributedString()
            attributedText.append(NSAttributedString(string: word + "\n", attributes: [
                NSFontAttributeName : UIFont.boldSystemFont(ofSize: 14),
                NSForegroundColorAttributeName : UIColor.white
                ]))
            
            navigationView.titleLabel.attributedText = attributedText
        }
        
      //  tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(UINib(nibName: "FlashCardViewCell", bundle: nil), forCellReuseIdentifier: "FlashCardViewCell")
        tableView.dataSource = self
      
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension WordViewController {
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        // guard (indexPath as NSIndexPath).row < list.count else { return 0 }
        // let list1 = list[(indexPath as NSIndexPath).row]
        //    let width = UIScreen.main.bounds.size.width
        //return TWTRTweetTableViewCell.height(for: tweet, style: .compact, width: width, showingActions: false)
        return FlashCardViewCell.Height
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) {
        if (indexPath as NSIndexPath).row < 1 {
            //loadTweets()
        }
    }
}

extension WordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      //  print("HERE-------------------------");
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlashCardViewCell") as! FlashCardViewCell
   //     print("HERE-------------------------");
        let rectangle = UIView(frame: CGRect(x: 5, y: 10, width: cell.frame.size.width - 10, height: 500))
        
        rectangle.layer.borderColor = UIColor.darkGray.cgColor
        rectangle.layer.borderWidth = 2.0
        rectangle.layer.cornerRadius = 10.0
        //rectangle.layer.backgroundColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 255 / 0, alpha: 1).cgColor
        // Add the rectangle to your cell
        

        
        cell.flashCardValue = (word!, "This is a Meaning", "This is first Sentence", "This is second Sentence", "This is third Sentence")
        rectangle.layer.zPosition = 0
        
        cell.addSubview(rectangle)
        rectangle.isUserInteractionEnabled = false
        return cell
    }
}
