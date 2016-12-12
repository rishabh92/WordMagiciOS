//
//  FlashCardViewCell.swift
//  WordMagic
//
//  Created by Rishabh Singh on 11/9/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//



import UIKit

import CoreData
class FlashCardViewCell: UITableViewCell {
    static let Height: CGFloat = 600
    var wordName:Word? = nil
    var chartdata = ChartData(key: "down")

    @IBOutlet weak var buttonOne: UIButton!
    
    @IBOutlet weak var buttonTwo: UIButton!

    @IBOutlet weak var buttonThree: UIButton!
    
    @IBOutlet weak var buttonFour: UIButton!
    
    @IBOutlet weak var buttonFive: UIButton!
     var setControl = SetViewController()
    var wordListControl = WordListViewController()
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var meaningLabel: UILabel!
    @IBOutlet weak var sentenceLabel1: UILabel!
   
    @IBAction func levelButtonPressed(_ sender: UIButton) {
        print("Click Happened")
        changePriorButton()
        sender.backgroundColor = UIColor.brown
        sender.isEnabled = false
        setLevel(level: Int((sender.titleLabel?.text)!)!)
        
    }
    
    var flashCardValue: (String, String, String)? {
        didSet {
            guard let value = flashCardValue else { return }
            let word = value.0
            let meaning = value.1
            let sentence1 = value.2
            wordLabel.text = word
            meaningLabel.text = meaning
            sentenceLabel1.text = sentence1
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setLevel(level: Int){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        if((wordName?.level)!>Int16(level)){
            chartdata.levelOfWordChanged(key: "down")
        }
        wordName?.level = Int16(level)
        try! context.save()
        print(wordName?.spelling)
        print(wordName?.level)
        setControl.reloadData()
        
    }
    func changePriorButton(){
            buttonOne.backgroundColor = UIColor.gray
        
            buttonOne.isEnabled = true;
        
            buttonTwo.backgroundColor = UIColor.gray
           //buttonTwo.isHighlighted = false;
            buttonTwo.isEnabled = true;
       
            buttonThree.backgroundColor = UIColor.gray
           // buttonThree.isHighlighted = false;
            buttonThree.isEnabled = true;
       
            buttonFour.backgroundColor = UIColor.gray
           // buttonFour.isHighlighted = false;
            buttonFour.isEnabled = true;
       
            buttonFive.backgroundColor = UIColor.gray
          //  buttonFive.isHighlighted = false;
            buttonFive.isEnabled = true;

        
    }
}

