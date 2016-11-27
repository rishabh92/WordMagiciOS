//
//  FlashCardViewCell.swift
//  WordMagic
//
//  Created by Rishabh Singh on 11/9/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//



import UIKit


class FlashCardViewCell: UITableViewCell {
    static let Height: CGFloat = 600
    
    

    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var meaningLabel: UILabel!
    
    
    @IBOutlet weak var sentenceLabel1: UILabel!
 
    @IBOutlet weak var sentenceLabel2: UILabel!
   
    
    @IBOutlet weak var sentenceLabel3: UILabel!

    @IBAction func levelButtonPressed(_ sender: UIButton) {
        print("Click Happende")
        if sender.titleLabel?.text == "1" {
            print("here")
            
        } else if sender.titleLabel?.text == "2" {
            print("there 1")
        }else if sender.titleLabel?.text == "3" {
            print("there2")
        }else if sender.titleLabel?.text == "4" {
            print("there 3")
        }
        else if sender.titleLabel?.text == "5" {
            print("there 4")
        }
    }
    
    var flashCardValue: (String , String, String, String, String )? {
        didSet {
            guard let value = flashCardValue else { return }
            let word = value.0
            let meaning = value.1
            let sentence1 = value.2
            let sentence2 = value.3
            let sentence3 = value.4
            wordLabel.text = word
            meaningLabel.text = "Meaning: " + meaning
            sentenceLabel1.text = sentence1
            sentenceLabel2.text = sentence2
            sentenceLabel3.text = sentence3
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

