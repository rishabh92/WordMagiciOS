//
//  File.swift
//  WordMagic
//
//  Created by Haider Hameed on 12/3/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//

import Foundation

class SRAElem {
    var word: Word
    var state: Int = 0
    
    init(word: Word) {
        self.word = word
        state = 0
    }
}
