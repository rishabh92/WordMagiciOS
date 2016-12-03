//
//  PraticeViewController.swift
//  WordMagic
//
//  Created by Rishabh Singh on 11/26/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//

import UIKit
import HoverConversion
class PraticeViewController: UIViewController {
   // @IBOutlet weak var meaningButton: UIButton!

   /* @IBAction func meaningButtonPressed(_ sender: UIButton) {
       
        UIView.animate(withDuration: 1, delay: 0.2, options:
            UIViewAnimationOptions.transitionFlipFromLeft, animations: {
                self.MeaningLabel.alpha = 1
                self.meaningButton.alpha = 0
            }, completion: { finished in
                self.MeaningLabel.isHidden = false;
                self.meaningButton.isHidden = true;
                
        })
    }*/
    var cardView: UIView!
    var back: UIImageView!
    var front: UIImageView!
    var showingBack = true
    var dynamicTextViewInsideImageView : UILabel!
    var dynamicMeaningInsideImageView : UILabel!
    var progressView: UIProgressView!
    var progressLabel: UILabel!
    
    @IBOutlet weak var WordLabel: UILabel!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       let rectangle = UIView(frame: CGRect(x: 10, y: 70, width: 350 , height: 100))
        rectangle.alpha = 0.8
        rectangle.layer.borderColor = UIColor.darkGray.cgColor
        rectangle.layer.borderWidth = 2.0
        rectangle.layer.cornerRadius = 10.0
        view.addSubview(rectangle)
     /*   let rectangle1 = UIView(frame: CGRect(x: 10, y: 250, width: 350 , height: 300))
        rectangle1.alpha = 0.8
        rectangle1.layer.borderColor = UIColor.darkGray.cgColor
        rectangle1.layer.borderWidth = 2.0
        rectangle1.layer.cornerRadius = 10.0
        view.addSubview(rectangle1)
        automaticallyAdjustsScrollViewInsets = false    */
        navigationController?.isNavigationBarHidden = false
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 85 / 255, green: 172 / 255, blue: 238 / 255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
     //   navigationController?.navigationBar.topItem?.title = "Practice"
        let testUIBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector (nextButtonPressed))
        self.navigationItem.rightBarButtonItem  = testUIBarButtonItem
        
        let attrs = [
            NSForegroundColorAttributeName: UIColor.white,
          //  NSFontAttributeName: UIFont(name: "Georgia-Bold", size: 24)!
        ]
        navigationController?.navigationBar.titleTextAttributes = attrs
    //    rectangle.isUserInteractionEnabled = false
      //  rectangle1.isUserInteractionEnabled = false
        
        front = UIImageView(image: UIImage(named: "flashcard.png"))
        back = UIImageView(image: UIImage(named: "flashcard.png"))
        back.frame = CGRect(x:0,y: 0,width: 350,height: 300)
        front.frame = CGRect(x:0,y: 0,width: 350,height: 300)

        let singleTap = UITapGestureRecognizer(target: self, action: #selector (tapped))
        
        back.addGestureRecognizer(singleTap)
        back.isUserInteractionEnabled = true
        singleTap.numberOfTapsRequired = 1
        
        let rect = CGRect(x:10,y: 200,width: (back.frame.size.width),height: (back.frame.size.height))
        cardView = UIView(frame: rect)
        cardView.addSubview(back)
        cardView.addGestureRecognizer(singleTap)
        cardView.isUserInteractionEnabled = true
        view.addSubview(cardView)
        dynamicTextViewInsideImageView = UILabel(frame: CGRect(x:120,y: 100,width: 200,height: 50))
        dynamicTextViewInsideImageView.text = "Press to show"
        cardView.addSubview( dynamicTextViewInsideImageView)
        dynamicMeaningInsideImageView = UILabel(frame: CGRect(x:130,y: 100,width: 300,height: 50))
        dynamicMeaningInsideImageView.text = "Meaning"
        progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.default)
        progressView.frame = CGRect(x:40,y: 560,width: 300,height: 50)
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 5)
        progressLabel = UILabel(frame: CGRect(x:120,y: 520,width: 200,height: 50))
        progressLabel.text = " Mastering 0 words"
        view.addSubview(progressLabel)
        view.addSubview(progressView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    

    }
    func nextButtonPressed(){
       
        WordLabel.text = "abcd"
        UIView.transition(from: front, to: back, duration: 0, completion: nil)
        showingBack = true
        cardView.addSubview( dynamicTextViewInsideImageView)
        progressView.progress += 0.1
        let progressValue = self.progressView?.progress
        progressLabel?.text = "Mastering \(progressValue! * 10) words"
    }

    func tapped() {
        if (showingBack) {
            UIView.transition(from: back, to: front, duration: 1, options: UIViewAnimationOptions.transitionFlipFromRight, completion: nil)
            showingBack = false
            cardView.addSubview( dynamicMeaningInsideImageView)
        } else {
            UIView.transition(from: front, to: back, duration: 1, options: UIViewAnimationOptions.transitionFlipFromLeft, completion: nil)
            showingBack = true
            cardView.addSubview( dynamicTextViewInsideImageView)
        }
    }


}
