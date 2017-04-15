//
//  Item+CoreDataClass.swift
//  Project333
//
//  Created by Eric Wei on 2017-04-01.
//  Copyright © 2017 EricWei. All rights reserved.
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
