//
//  WordViewController.swift
//  WordMagic
//
//  Created by Rishabh Singh on 11/9/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//

import UIKit
import HoverConversion
import CoreData
import Foundation

class WordViewController: HCContentViewController {
    var word: Word?
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
        print("HDSJADSJD")
        print(word?.spelling)
      
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlashCardViewCell") as! FlashCardViewCell
        let rectangle = UIView(frame: CGRect(x: 5, y: 10, width: cell.frame.size.width - 10, height: 500))
        
        rectangle.layer.borderColor = UIColor.darkGray.cgColor
        rectangle.layer.borderWidth = 2.0
        rectangle.layer.cornerRadius = 10.0
   
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
        cell.wordName = word!
        let level = Int((word?.level)!)
        switch(level){
        case 1:
            cell.buttonOne.isHighlighted = true;
            cell.buttonOne.isEnabled = false;
            break;
        case 2:
            cell.buttonTwo.isHighlighted = true;
            cell.buttonTwo.isEnabled = false;
            break;
        case 3:
            cell.buttonThree.isHighlighted = true;
            cell.buttonThree.isEnabled = false;
            break;
        case 4:
            cell.buttonFour.isHighlighted = true;
            cell.buttonFour.isEnabled = false;
            break;
        case 5:
            cell.buttonFive.isHighlighted = true;
            cell.buttonFive.isEnabled = false;
            break;
        default:
            cell.buttonZero.isHighlighted = true;
            cell.buttonZero.isEnabled = false;
            break
        }
        
        return cell
    }
}
