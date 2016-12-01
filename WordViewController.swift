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
    var word: Word? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationView.backgroundColor = UIColor(red: 85 / 255, green: 172 / 255, blue: 238 / 255, alpha: 1)
        

            navigationView.titleLabel.numberOfLines = 1
            let attributedText = NSMutableAttributedString()
            attributedText.append(NSAttributedString(string: (word?.spelling!)! + "\n", attributes: [
                NSFontAttributeName : UIFont.boldSystemFont(ofSize: 14),
                NSForegroundColorAttributeName : UIColor.white
                ]))
            
            navigationView.titleLabel.attributedText = attributedText

        
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
        
        var sentences = String()
        
        for sentence in (word?.sentences)! {
            let sent: Sentence = sentence as! Sentence
            sentences += sent.statement!
            sentences += "\n\n"
        }
        
        cell.flashCardValue = ((word?.spelling!)!, (word?.meaning)!, sentences)
        rectangle.layer.zPosition = 0
        
        cell.addSubview(rectangle)
        rectangle.isUserInteractionEnabled = false
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
}
