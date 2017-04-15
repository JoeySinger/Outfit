//
//  SavedOutfitViewController.swift
//  Project333
//
//  Created by Eric Wei on 2017-04-07.
//  Copyright © 2017 EricWei. All rights reserved.
//

import Foundation
import UIKit

class SavedOutfitViewController: ViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var items: [Item]!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //collection methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SavedItemViewCell", for: indexPath) as! SavedItemViewCell
        cell.savedItemImage.image = UIImage(data: items[indexPath.row].imageData as! Data)
        
        return cell
    }
    
    
    func setupViewCells() {
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2*space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = 0.1
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
}
