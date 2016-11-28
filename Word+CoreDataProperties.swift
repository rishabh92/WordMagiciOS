//
//  Word+CoreDataProperties.swift
//  WordMagic
//
//  Created by Haider Hameed on 11/27/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//

import Foundation
import CoreData


extension Word {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: "Word");
    }

    @NSManaged public var level: Int16
    @NSManaged public var meaning: String?
    @NSManaged public var spelling: String?
    @NSManaged public var sentences: NSSet?
    @NSManaged public var set: Set?

}

// MARK: Generated accessors for sentences
extension Word {

    @objc(addSentencesObject:)
    @NSManaged public func addToSentences(_ value: Sentence)

    @objc(removeSentencesObject:)
    @NSManaged public func removeFromSentences(_ value: Sentence)

    @objc(addSentences:)
    @NSManaged public func addToSentences(_ values: NSSet)

    @objc(removeSentences:)
    @NSManaged public func removeFromSentences(_ values: NSSet)

}
