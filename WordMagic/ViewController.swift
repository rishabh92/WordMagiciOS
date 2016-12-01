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
    
    var cardView: UIView!
    var back: UIImageView!
    var front: UIImageView!
    var showingBack = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        front = UIImageView(image: UIImage(named: "image1.jpg"))
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
        view.addSubview(cardView)
        
      
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

