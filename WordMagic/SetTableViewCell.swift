//
//  SetTableViewCell.swift
//  WordMagic
//
//  Created by Rishabh Singh on 11/21/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//



import UIKit


class SetTableViewCell: UITableViewCell {
    static let Height: CGFloat = 100
    @IBOutlet weak var SetLabel: UILabel!
    
    var setValue: (String?)? {
        didSet {
            guard let value = setValue else { return }
            let set = value
            SetLabel.text = set
            
        }
    }
    
    @IBAction func onPracticeClick(_ sender: UIButton) {
        print("here")
   // performSegue("toSecondCtroller", sender: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
