//
//  FlashCardViewCell.swift
//  WordMagic
//
//  Created by Rishabh Singh on 11/8/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//

import UIKit
import HoverConversion
import MisterFusion





class NextHeaderView: HCNextHeaderView {
    var word: String? {
        didSet {
            guard let word = word else { return }
            setupViews()
            
//            titleLabel.numberOfLines = 2
//            let attributedText = NSMutableAttributedString()
//            attributedText.append(NSAttributedString(string: user.name + "\n", attributes: [
//                NSFontAttributeName : UIFont.boldSystemFont(ofSize: 18),
//                NSForegroundColorAttributeName : UIColor.white
//                ]))
//            attributedText.append(NSAttributedString(string: "@" + user.screenName, attributes: [
//                NSFontAttributeName : UIFont.systemFont(ofSize: 16),
//                NSForegroundColorAttributeName : UIColor(white: 1, alpha: 0.6)
//                ]))
//            titleLabel.attributedText = attributedText
            

        }
    }
//    
//    let iconImageView: UIImageView! = UIImageView(frame: .zero)
//    let titleLabel: UILabel = UILabel(frame: .zero)
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        iconImageView.layer.cornerRadius = iconImageView.bounds.size.height / 2
    }
    
    fileprivate func setupViews() {
//        addLayoutSubview(iconImageView, andConstraints:
//            iconImageView.top |+| 8,
//            iconImageView.left |+| 8,
//            iconImageView.bottom |-| 8,
//            iconImageView.width |==| iconImageView.height
//        )
//
//        iconImageView.layer.borderWidth = 1
//        iconImageView.layer.borderColor = UIColor.lightGray.cgColor
//        iconImageView.layer.masksToBounds = true
//        
//        addLayoutSubview(titleLabel, andConstraints:
//            titleLabel.top |+| 4,
//            titleLabel.right |-| 4,
//            titleLabel.left |==| iconImageView.right |+| 16,
//            titleLabel.bottom |-| 4
//        )
        
        backgroundColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1)
    }
}
