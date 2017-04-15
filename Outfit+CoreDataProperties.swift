//
//  Outfit+CoreDataProperties.swift
//  OutfitMe
//
//  Created by Joey Singer on 2017-04-13.
//  Copyright © 2017 Joey Singer. All rights reserved.
//

import Foundation
import CoreData


extension Outfit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Outfit> {
        return NSFetchRequest<Outfit>(entityName: "Outfit")
    }

    @NSManaged public var name: String?
    @NSManaged public var item1: Item?
    @NSManaged public var item2: Item?
    @NSManaged public var item3: Item?
    @NSManaged public var item4: Item?
    @NSManaged public var item5: Item?
    @NSManaged public var item6: Item?
    @NSManaged public var item7: Item?
    @NSManaged public var item8: Item?
    @NSManaged public var item9: Item?
    @NSManaged public var item10: Item?

}
