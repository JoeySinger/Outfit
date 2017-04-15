//
//  PickOutfitViewController.swift
//  Project333
//
//  Created by Eric Wei on 2017-04-05.
//  Copyright © 2017 EricWei. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PickOutfitViewController: UIViewController {
    
    //http://lybron.com/ios-programming-tutorials/2016/1/7/automatically-size-custom-uitableviewcell-to-fit-content
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var fromNewOutfitButton: Bool?
    var coreDataStack: CoreDataStack!
    var inputOutfitNameTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        print("the value of fromNewOutfitButton== \(fromNewOutfitButton)")
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        coreDataStack = delegate.stack
        
        tableView.estimatedRowHeight = 97.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        setupViewCells()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        //Saving today's outfit
        let numItems = ClothesArray.sharedDataSource().Outfit.count
        if numItems > 0{
            if self.fromNewOutfitButton! {
                print("there are \(numItems) items about to be saved in Today's outfit")
                
                let todaysOutfit = NSEntityDescription.insertNewObject(forEntityName: "Outfit", into: self.coreDataStack.context) as! Outfit
                todaysOutfit.name = "today"
                
                for i in 0..<numItems {
                    let itemID = coreDataStack.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation:  ClothesArray.sharedDataSource().Outfit[i])
                    
                    let item = try? coreDataStack.context.object(with: itemID!) as! Item
                    
                    switch i {
                    case 0:
                        todaysOutfit.item1 = item
                    case 1:
                        todaysOutfit.item2 = item
                    case 2:
                        todaysOutfit.item3 = item
                    case 3:
                        todaysOutfit.item4 = item
                    case 4:
                        todaysOutfit.item5 = item
                    case 5:
                        todaysOutfit.item6 = item
                    case 6:
                        todaysOutfit.item7 = item
                    case 7:
                        todaysOutfit.item8 = item
                    case 8:
                        todaysOutfit.item9 = item
                    case 9:
                        todaysOutfit.item10 = item
                    default:
                        print("saving outfit error")
                    }
                }
                self.coreDataStack.save()
            }
            let alert = UIAlertController(title: "", message: "Save this outfit?", preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (textfield) in
                self.inputOutfitNameTextField = textfield
                self.inputOutfitNameTextField.placeholder = "Outfit Name"
            })
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                if self.inputOutfitNameTextField.text == nil {
                    self.inputOutfitNameTextField.text = "unamed outfit"
                }
                self.saveOutfit(numItems: numItems, outfitName: self.inputOutfitNameTextField.text!)
            }))
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "", message: "No items selected!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func saveOutfit(numItems: Int, outfitName: String)  {
        let outfitToSave = NSEntityDescription.insertNewObject(forEntityName: "Outfit", into: self.coreDataStack.context) as! Outfit
        outfitToSave.name = outfitName
        
        for i in 0..<numItems {
            let itemID = coreDataStack.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation:  ClothesArray.sharedDataSource().Outfit[i])
            
            let item = try? coreDataStack.context.object(with: itemID!) as! Item
            
            switch i {
            case 0:
                outfitToSave.item1 = item
            case 1:
                outfitToSave.item2 = item
            case 2:
                outfitToSave.item3 = item
            case 3:
                outfitToSave.item4 = item
            case 4:
                outfitToSave.item5 = item
            case 5:
                outfitToSave.item6 = item
            case 6:
                outfitToSave.item7 = item
            case 7:
                outfitToSave.item8 = item
            case 8:
                outfitToSave.item9 = item
            case 9:
                outfitToSave.item10 = item
            default:
                print("saving outfit error")
            }
        }
        self.coreDataStack.save()
        //clean outfit array, dismiss
        ClothesArray.sharedDataSource().Outfit.removeAll()
        dismiss(animated: true, completion: nil)
    }
}


extension PickOutfitViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ClothesArray.sharedDataSource().Outfit.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PickCollectionCell", for: indexPath) as! PickItemViewCell
        
        let itemID = coreDataStack.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation:  ClothesArray.sharedDataSource().Outfit[indexPath.row])
        
        if let item = try? coreDataStack.context.object(with: itemID!) as! Item {
            cell.itemImageView.image = UIImage(data: item.imageData! as Data)
        }
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

extension PickOutfitViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClothesArray.sharedDataSource().ClothesCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PickTableCell")!
        cell.textLabel?.text = ClothesArray.sharedDataSource().ClothesCategory[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ClothesCollectionViewController") as! ClothesCollectionViewController
        controller.CategoryIndex = indexPath.row
        controller.isSelectingItems = true
        self.navigationController!.pushViewController(controller, animated: true)
    }
    
}
