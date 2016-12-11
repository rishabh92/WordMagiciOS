//
//  AllWordSelector.swift
//  WordMagic
//
//  Created by Haider Hameed on 12/11/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class AllWordSelector: WordSelector {
    override func get_words() -> [SRAElem] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let setsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Word")
        do {
            var words = try context.fetch(setsFetch) as! [Word]
            words = words.sorted{ _,_ in arc4random() % 2 == 0 }
            return Array(words.prefix(50)).map{ SRAElem(word: $0) }
        } catch {
            fatalError("Failed to fetch : \(error)")
        }
    }
}
