//
//  Set+CoreDataProperties.swift
//  WordMagic
//
//  Created by Haider Hameed on 11/27/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//

import Foundation
import CoreData


extension Set {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Set> {
        return NSFetchRequest<Set>(entityName: "Set");
    }

    @NSManaged public var name: String?
    @NSManaged public var words: NSSet?

}

// MARK: Generated accessors for words
extension Set {

    @objc(addWordsObject:)
    @NSManaged public func addToWords(_ value: Word)

    @objc(removeWordsObject:)
    @NSManaged public func removeFromWords(_ value: Word)

    @objc(addWords:)
    @NSManaged public func addToWords(_ values: NSSet)

    @objc(removeWords:)
    @NSManaged public func removeFromWords(_ values: NSSet)

}
