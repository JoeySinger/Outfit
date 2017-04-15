//
//  Item+CoreDataClass.swift
//  OutfitMe
//
//  Created by Joey Singer on 2017-04-13.
//  Copyright © 2017 Joey Singer. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    
    convenience init(category: String, subCategory: String, imageData: Data, context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: "Item", in: context){
            self.init(entity: ent, insertInto: context)
            self.category = category
            self.subcategory = subCategory
            self.imageData = imageData as NSData
        } else{
            fatalError("Unable to find Item Entity name!")
        }
    }
}
