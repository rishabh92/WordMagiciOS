//
//  Sentence+CoreDataProperties.swift
//  WordMagic
//
//  Created by Haider Hameed on 11/27/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//

import Foundation
import CoreData


extension Sentence {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sentence> {
        return NSFetchRequest<Sentence>(entityName: "Sentence");
    }

    @NSManaged public var statement: String?
    @NSManaged public var word: Word?

}
