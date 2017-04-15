//
//  OutfitViewController.swift
//  Project333
//
//  Created by Eric Wei on 2017-04-03.
//  Copyright © 2017 EricWei. All rights reserved.
//

import Foundation
import UIKit

class OutfitViewController: UICollectionViewController {
    
    @IBOutlet weak var outfitCollectionView: UICollectionView!
    var chosenCategoryIndex: Int!
    
    override func viewDidLoad() {
        print("OutfitViewController  here!!!")
    }
    
    //collection view methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ClothesArray.sharedDataSource().ClothesCategory.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! OutfitItemViewCell
        cell.categoryLabel.text = ClothesArray.sharedDataSource().ClothesCategory[indexPath.row]
        cell.detailInfoLabel.text = "Click cell to add item"
        cell.outfitItemImage.image = UIImage(named: "Placeholder")
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ClothesCollectionViewController") as! ClothesCollectionViewController
        controller.CategoryIndex = indexPath.row
        self.navigationController!.pushViewController(controller, animated: true)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
