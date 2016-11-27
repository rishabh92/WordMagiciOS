//
//  Word+CoreDataProperties.swift
//  
//
//  Created by Rishabh Singh on 11/14/16.
//
//

import Foundation
import CoreData


extension Word {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: "Word");
    }

    @NSManaged public var meaning: String?
    @NSManaged public var spelling: String?
    @NSManaged public var set: Set?

}
