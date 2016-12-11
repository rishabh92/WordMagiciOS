//
//  SpacedRepetitionAlgo.swift
//  WordMagic
//
//  Created by Haider Hameed on 12/3/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class SpacedRepetitionAlgo {
    var words: [SRAElem]
    var next_state: [Int]
    
    init(){
        let sel = LevelWordSelector(level: 0)
        words = sel.get_words()
        next_state = [-1, 3, 7, -1, -1]
    }
    
    func has_next() -> Bool {
        return get_mastered() < words.count
    }
    
    func get_next() -> SRAElem {
        return words[0]
    }
    
    func mark_yes() {
        let word = words.remove(at: 0)
        let state = next_state[word.state]
        if state < 0 {
            word.state = 4
            words.append(word)
        } else {
            word.state += 1
            words.insert(word, at: state)
        }
    }
    
    func mark_no() {
        let word = words.remove(at: 0)
        word.state = 1
        words.insert(word, at: 1)
    }
    
    func get_total() -> Int {
        return words.count
    }
    
    func get_mastered() -> Int {
        return get_count(state: 4)
    }
    
    func get_reviewing() -> Int {
        return get_count(state: 2) + get_count(state: 3)
    }
    
    func get_learning() -> Int {
        return get_count(state: 1)
    }
    
    func get_count(state: Int) -> Int {
        var mastered: Int = 0
        for word in words {
            if word.state == state {
                mastered += 1
            }
        }
        return mastered
    }
}
