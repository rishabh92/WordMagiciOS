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

   /* @IBAction func meaningButtonPresse@objc @objc @objc @objc @objc d(_ sender: UIButton) {
       
        UIView.animate(withDuration: 1, delay: 0.2, options:
            UIViewAnimationOptions.transitionFlipFromLeft, animations: {
                self.MeaningLabel.alpha = 1
                self.meaningButton.alpha = 0
            }, completion: { finished in
                self.MeaningLabel.isHidden = false;
                self.meaningButton.isHidden = true;
                
        })
    }*/
    var firstTime = true;
    var cardView: UIView!
    var back: UIImageView!
    var front: UIImageView!
    var showingBack = true
    var dynamicTextViewInsideImageView : UILabel!
    var dynamicMeaningInsideImageView : UILabel!
    var dynamicSentencesInsideImageView : UILabel!
    var knowThisWord : UIButton!
    var dontKnowThisWord : UIButton!
    var progressView: UIProgressView!
    var progressLabel: UILabel!
    var learningView: UIProgressView!
    var learningLabel: UILabel!
    var reviewingView: UIProgressView!
    var reviewingLabel: UILabel!
    var spacedAlgo = SpacedRepetitionAlgo();
    @IBOutlet weak var WordLabel: UILabel!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       let rectangle = UIView(frame: CGRect(x: 10, y: 70, width: 350 , height: 90))
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

        front = UIImageView(image: UIImage(named: "flashcard.png"))
        back = UIImageView(image: UIImage(named: "flashcard.png"))
        back.frame = CGRect(x:0,y: 0,width: 350,height: 340)
        front.frame = CGRect(x:0,y: 0,width: 350,height: 340)

        let singleTap = UITapGestureRecognizer(target: self, action: #selector (tapped))
        
        back.addGestureRecognizer(singleTap)
        back.isUserInteractionEnabled = true
        singleTap.numberOfTapsRequired = 1
        
        let rect = CGRect(x:10,y: 170,width: (back.frame.size.width),height: (back.frame.size.height))
        cardView = UIView(frame: rect)
        cardView.addSubview(back)
        cardView.addGestureRecognizer(singleTap)
        cardView.isUserInteractionEnabled = true
        view.addSubview(cardView)
        dynamicTextViewInsideImageView = UILabel(frame: CGRect(x:120,y: 100,width: 200,height: 50))
        dynamicTextViewInsideImageView.text = "Press to show"
        cardView.addSubview( dynamicTextViewInsideImageView)
        dynamicMeaningInsideImageView = UILabel(frame: CGRect(x:30,y: 30,width: 300,height: 50))
        dynamicMeaningInsideImageView.numberOfLines = 4
        //dynamicMeaningInsideImageView.text = "Meaning"
        dynamicSentencesInsideImageView = UILabel(frame: CGRect(x:30,y: 80,width: 300,height: 200))
        dynamicSentencesInsideImageView.numberOfLines = 13
        knowThisWord = UIButton(frame: CGRect(x:100,y: 300,width: 40,height: 30))
        knowThisWord.backgroundColor = UIColor.gray
        knowThisWord.addTarget(self, action: #selector(markKnown), for: UIControlEvents.touchUpInside)
        knowThisWord.setTitle("Yes", for: UIControlState.normal)
        dontKnowThisWord = UIButton(frame: CGRect(x:200,y: 300,width: 40,height: 30))
        dontKnowThisWord.backgroundColor = UIColor.gray
        dontKnowThisWord.addTarget(self, action: #selector(markUnKnown), for: UIControlEvents.touchUpInside)
        dontKnowThisWord.setTitle("No", for: UIControlState.normal)
        progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.default)
        progressView.frame = CGRect(x:40,y: 540,width: 300,height: 50)
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 4)
        progressLabel = UILabel(frame: CGRect(x:120,y: 500,width: 200,height: 50))
        progressLabel.text = " Mastering 0 words"
        view.addSubview(progressLabel)
        view.addSubview(progressView)
        learningView = UIProgressView(progressViewStyle: UIProgressViewStyle.default)
        learningView.frame = CGRect(x:40,y: 600,width: 300,height: 20)
        learningView.transform = progressView.transform.scaledBy(x: 1, y: 1)
        learningLabel = UILabel(frame: CGRect(x:120,y: 560,width: 200,height: 50))
        learningLabel.text = " Learning   0 words"
        view.addSubview(learningLabel)
        view.addSubview(learningView)
        reviewingView = UIProgressView(progressViewStyle: UIProgressViewStyle.default)
        reviewingView.frame = CGRect(x:40,y: 570,width: 300,height: 20)
        reviewingView.transform = progressView.transform.scaledBy(x: 1, y: 1)
        reviewingLabel = UILabel(frame: CGRect(x:120,y: 530,width: 200,height: 50))
        reviewingLabel.text = " Reviewing 0 words"
        view.addSubview(reviewingLabel)
        view.addSubview(reviewingView)
        WordLabel.text = spacedAlgo.get_next().word.spelling
        dynamicMeaningInsideImageView.text = spacedAlgo.get_next().word.meaning
        
        
        
        dynamicSentencesInsideImageView.text = get_sentences(value: spacedAlgo.get_next())
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    

    }
    func markKnown(){
        print("yes")
        spacedAlgo.mark_yes()
        nextButtonPressed()
      
    }
    func markUnKnown(){
        print("no")
        spacedAlgo.mark_no()
        nextButtonPressed()
        
    }
    func nextButtonPressed(){
       
        if(spacedAlgo.has_next()){
            let word = spacedAlgo.get_next()
            WordLabel.text = word.word.spelling
            dynamicMeaningInsideImageView.text = word.word.meaning
            dynamicSentencesInsideImageView.text = get_sentences(value: word)
            UIView.transition(from: front, to: back, duration: 0, completion: nil)
            showingBack = true
            cardView.addSubview( dynamicTextViewInsideImageView)
            let mastered = spacedAlgo.get_mastered()
            print(mastered)
            progressView.progress = Float(mastered)/50.0
            let progressValue = mastered
            progressLabel?.text = "Mastering \(progressValue) words"
            let learning = spacedAlgo.get_learning()
            learningView.progress = Float(learning)/50.0
            let learningValue = learning
            learningLabel?.text = "Learning \(learningValue) words"
            let reviewing = spacedAlgo.get_learning()
            reviewingView.progress = Float(reviewing)/50.0
            let reviewingValue = reviewing
            reviewingLabel?.text = "Reviewing \(reviewingValue) words"
        }
        
    }
    func get_sentences(value: SRAElem) -> String {
        
        var sentences = String()
        for sentence in (value.word.sentences)! {
            let sent: Sentence = sentence as! Sentence
            sentences += sent.statement!
            sentences += "\n\n"
        }
        return sentences
        
    }

    func tapped() {
        if (showingBack) {
            UIView.transition(from: back, to: front, duration: 1, options: UIViewAnimationOptions.transitionFlipFromRight, completion: nil)
            showingBack = false
            cardView.addSubview( dynamicMeaningInsideImageView)
            cardView.addSubview( dynamicSentencesInsideImageView)
            cardView.addSubview(knowThisWord)
            cardView.addSubview(dontKnowThisWord)
        } else {
            UIView.transition(from: front, to: back, duration: 1, options: UIViewAnimationOptions.transitionFlipFromLeft, completion: nil)
            showingBack = true
            cardView.addSubview( dynamicTextViewInsideImageView)
        }
    }


}
