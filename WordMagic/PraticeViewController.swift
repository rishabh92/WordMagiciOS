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
    @IBOutlet weak var meaningButton: UIButton!

    @IBAction func meaningButtonPressed(_ sender: UIButton) {
        self.meaningButton.isHidden = true;
        self.MeaningLabel.isHidden = false;
    }

    
    @IBOutlet weak var WordLabel: UILabel!
    
    @IBOutlet weak var MeaningLabel: UILabel!
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.MeaningLabel.isHidden = true;
        self.meaningButton.isHidden = false;
        WordLabel.text = "abcd"
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.MeaningLabel.isHidden = true;
        
        // Do any additional setup after loading the view.
       let rectangle = UIView(frame: CGRect(x: 10, y: 120, width: 350 , height: 100))
        rectangle.alpha = 0.8
        rectangle.layer.borderColor = UIColor.darkGray.cgColor
        rectangle.layer.borderWidth = 2.0
        rectangle.layer.cornerRadius = 10.0
        view.addSubview(rectangle)
        let rectangle1 = UIView(frame: CGRect(x: 10, y: 250, width: 350 , height: 300))
        rectangle1.alpha = 0.8
        rectangle1.layer.borderColor = UIColor.darkGray.cgColor
        rectangle1.layer.borderWidth = 2.0
        rectangle1.layer.cornerRadius = 10.0
        view.addSubview(rectangle1)
        automaticallyAdjustsScrollViewInsets = false
        navigationController?.isNavigationBarHidden = false

        navigationController?.navigationBar.barTintColor = UIColor(red: 85 / 255, green: 172 / 255, blue: 238 / 255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
     //   navigationController?.navigationBar.topItem?.title = "Practice"
        let attrs = [
            NSForegroundColorAttributeName: UIColor.white,
          //  NSFontAttributeName: UIFont(name: "Georgia-Bold", size: 24)!
        ]
        navigationController?.navigationBar.titleTextAttributes = attrs
        rectangle.isUserInteractionEnabled = false
        rectangle1.isUserInteractionEnabled = false
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
