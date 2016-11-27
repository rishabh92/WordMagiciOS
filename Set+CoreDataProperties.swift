//
//  Set+CoreDataProperties.swift
//  
//
//  Created by Rishabh Singh on 11/14/16.
//
//

import Foundation
import CoreData

extension Set {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Set> {
        return NSFetchRequest<Set>(entityName: "Set");
    }

    @NSManaged public var name: String?
    @NSManaged public var words: Word?

}
