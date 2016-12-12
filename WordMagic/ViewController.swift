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
    
    @IBOutlet weak var tutorialLabel: UILabel!
    var cardView: UIView!
    var back: UIImageView!
    var front: UIImageView!
    var showingBack = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     /*   front = UIImageView(image: UIImage(named: "image1.jpg"))
        back = UIImageView(image: UIImage(named: "back.jpg"))
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector (tapped))
      //  var tap = UITapGestureRecognizer(target: self, action: Selector("tappedMe"))
        back.addGestureRecognizer(singleTap)
        back.isUserInteractionEnabled = true
        singleTap.numberOfTapsRequired = 1
        
        let rect = CGRect(x:20,y: 20,width: (back.image?.size.width)!,height: (back.image?.size.height)!)
        cardView = UIView(frame: rect)
        cardView.addSubview(back)
        cardView.addGestureRecognizer(singleTap)
        cardView.isUserInteractionEnabled = true
        view.addSubview(cardView)*/
      
        
        tutorialLabel.text = "This is a word learning app. \n Words are contained in Sets, sets are random group of words. Words are fetched from server which we have build from scratch and stored in Core Data inside app. \n\nUSAGE \n To go back from a screen to previous screen just Swipe Right. In the word meaning Screen where you seen words, meaning and sentences, you can swipe up and down to see the next and previous word respectively. Change word level by clicking on the level bar.\n\n Sync with Server: To fetch new words from the server, go to the Profile section and press the sync now button. \n\n Report: The report shows the activities of the user. The top graph shows number of words that progressed from higher levels to lower levels and the lower graph shows level distribution of the words."
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tapped() {
        if (showingBack) {
            UIView.transition(from: back, to: front, duration: 1, options: UIViewAnimationOptions.transitionFlipFromRight, completion: nil)
            showingBack = false
        } else {
            UIView.transition(from: front, to: back, duration: 1, options: UIViewAnimationOptions.transitionFlipFromLeft, completion: nil)
            showingBack = true
        }
    }

}

