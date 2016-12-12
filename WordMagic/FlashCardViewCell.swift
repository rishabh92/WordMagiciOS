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
    
    @IBOutlet weak var buttonZero: UIButton!
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
        sender.isHighlighted = true
        
        if sender.titleLabel?.text == "1" {
            print("HERE")
            buttonOne.isHighlighted = true;
            buttonOne.isEnabled = false;
            setLevel(level: 1)
            
            
        } else if sender.titleLabel?.text == "2" {
            print("HERE 4jheioheo")
            buttonTwo.isHighlighted = true;
            buttonTwo.isEnabled = false;
             setLevel(level: 2)
           
        }else if sender.titleLabel?.text == "3" {
            buttonThree.isHighlighted = true;
            buttonThree.isEnabled = false;
            setLevel(level: 3)
            print("there2")
         
        }else if sender.titleLabel?.text == "4" {
            buttonFour.isHighlighted = true;
            buttonFour.isEnabled = false;
            setLevel(level: 4)
            print("there 3")
           
        }
        else if sender.titleLabel?.text == "5" {
            buttonFive.isHighlighted = true;
            buttonFive.isEnabled = false;
            setLevel(level: 5)
            print("there 4")
            
        }
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
        wordName?.level = Int16(level)
        try! context.save()
        print(wordName?.spelling)
        print(wordName?.level)
        setControl.viewDidLoad()
        
        }
    func changePriorButton(){
        let priorlevel:String = String(describing: wordName!.level)
        print(priorlevel)
       
        print("YEH")
        if priorlevel == Optional("1") {
            buttonOne.isHighlighted = false;
            buttonOne.isEnabled = true;
            
        } else if priorlevel == Optional("2") {
            buttonTwo.isHighlighted = false;
            buttonTwo.isEnabled = true;
        }else if priorlevel == Optional("3") {
            buttonThree.isHighlighted = false;
            buttonThree.isEnabled = true;
        }else if priorlevel == Optional("4") {
            buttonFour.isHighlighted = false;
            buttonFour.isEnabled = true;
        }
        else if priorlevel == Optional("5") {
            buttonFive.isHighlighted = false;
            buttonFive.isEnabled = true;
        }else{
            buttonZero.isHighlighted = false
            buttonZero.isEnabled = false
        }
    }
}

