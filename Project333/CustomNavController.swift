//
//  CustomNavController.swift
//  OutfitMe
//
//  Created by Joey Singer on 2017-04-13.
//  Copyright © 2017 Joey Singer. All rights reserved.
//

import Foundation
import UIKit

class CustomNavController: UINavigationController {
    
    var fromNewOutfitButton: Bool!
    
    override func viewDidLoad() {
        let controller = self.viewControllers[0] as! PickOutfitViewController
        controller.fromNewOutfitButton = fromNewOutfitButton
    }
    
}
