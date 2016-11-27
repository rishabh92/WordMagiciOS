//
//  FlashCardViewCell.swift
//  WordMagic
//
//  Created by Rishabh Singh on 11/9/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//


import UIKit


class HomeTableViewCell: UITableViewCell {
    static let Height: CGFloat = 80
    
    @IBOutlet weak var wordLabel: UILabel!
    
    
    @IBOutlet weak var levelLabel: UILabel!
    
    var wordValue: (String? , String )? {
        didSet {
            guard let value = wordValue else { return }
            let word = value.0
            let level = value.1
            wordLabel.text = word
            levelLabel.text = "level " + level
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
