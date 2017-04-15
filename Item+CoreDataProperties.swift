//
//  Item+CoreDataProperties.swift
//  OutfitMe
//
//  Created by Joey Singer on 2017-04-13.
//  Copyright © 2017 Joey Singer. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var category: String?
    @NSManaged public var imageData: NSData?
    @NSManaged public var subcategory: String?

}
