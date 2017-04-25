//
//  ClothesArray.swift
//  OutfitMe
//
//  Created by Joey Singer on 2017-04-13.
//  Copyright © 2017 Joey Singer. All rights reserved.
//

import Foundation

class ClothesArray: NSObject {
    
    let ClothesCategory = ["Tops","Bottoms","Shoes","Dresses","Accessories","Outerwear"]
    let OutfitMaxNumber = [3,1,1,1,3,1]
    
    var ClothesSubcategory = [["Blazers","Shirts","Sweaters","T-shirts","Sleeveless","Others"],
                              ["Shorts","Trousers","Skirts","Jeans","Others"],
                              ["Boots","Sneakers","Heels","Sandals","Others"],
                              ["Gowns", "Cocktail Dresses","Strapless Dresses","Others"],
                              ["Watches","Sunglasses","Belts","Hats","Necklaces","Bracelets","Rings","Others"],
                              ["Jackets","Coats","Others"]]
    
    var TodaysOutfit = [Item]()
    
    var Outfit = [URL]()
    
    
    static var sharedInstance = ClothesArray()
    
    class func sharedDataSource() -> ClothesArray {
        return sharedInstance
    }
    
}
