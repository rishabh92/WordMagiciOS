//
//  ViewController.swift
//  WordMagic
//
//  Created by Rishabh Singh on 11/7/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var HelpLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let text:String = "This is a word learning app. \n Words are contained in Sets, sets are random group of words. Words are fetched from server which we have build from scratch and stored in Core Data inside app. \n\nUSAGE \nCurrently, Set feature is complete.To go back from a screen to previous screen just Swipe Right. In the word meaning Screen where you seen words, meaning and sentences, you can swipe up and down to see the next and previous word respectively. \n\n NOTE: For the first time, app will take some time as it would be loading data from server. Screen may be blank for several seconds."
        HelpLabel.text = text
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

