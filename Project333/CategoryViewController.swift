//
//  CategoryViewController.swift
//  Project333
//
//  Created by Eric Wei on 2017-03-30.
//  Copyright © 2017 EricWei. All rights reserved.
//

import Foundation
import MobileCoreServices
import UIKit
import CoreData

class CategoryViewController: UITableViewController{
    
    private var imagePicker: UIImagePickerController!
    var itemImage: UIImage!
    static var isAddingItem: Bool!
    var chosenCategoryIndex: Int!
    var chosenCategory: String!
    var numItemsForCategories = [Int]()
    var coreDataStack: CoreDataStack!
    var totalItems: Int!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        print("isAddingItem == \(CategoryViewController.isAddingItem)")
        getNumItemsForCategories()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        CategoryViewController.isAddingItem = false
    }
    
    //tableview methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection() called")
        return ClothesArray.sharedDataSource().ClothesCategory.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt() called   isEditing==\(CategoryViewController.isAddingItem)")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryViewCell
        
        cell.categoryCell.text = ClothesArray.sharedDataSource().ClothesCategory[indexPath.row]
        if CategoryViewController.isAddingItem {
            cell.numItemsCell.text = ""
        } else{
            cell.numItemsCell.text = "\(numItemsForCategories[indexPath.row]) items"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt() called   isEditing==\(isEditing)")
        
        if CategoryViewController.isAddingItem {
            chosenCategory = ClothesArray.sharedDataSource().ClothesCategory[indexPath.row]
            chosenCategoryIndex = indexPath.row
            self.performSegue(withIdentifier: "SubcategorySegue", sender: self)
        } else{
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "ClothesCollectionViewController") as! ClothesCollectionViewController
            controller.CategoryIndex = indexPath.row
            self.navigationController!.pushViewController(controller, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! SubcategoryViewController
        
        controller.subcategoryItems = ClothesArray.sharedDataSource().ClothesSubcategory[self.chosenCategoryIndex]
        controller.category = chosenCategory
        controller.itemImage = self.itemImage
    }
    
    func getNumItemsForCategories() {
        if coreDataStack == nil {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            coreDataStack = delegate.stack
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        numItemsForCategories.removeAll()
        
        if let fetchAllItems = try? coreDataStack.context.fetch(fetchRequest) as! [Item] {
            //print("total number of items == \(fetchAllItems.count)")
            if fetchAllItems.count == 33 {
                addButton.isEnabled = false
                self.navigationItem.title = "33/33 Items"
            } else {
                self.navigationItem.title = "\(fetchAllItems.count)/33 Items"
            }
        }
        
        for i in 0..<ClothesArray.sharedDataSource().ClothesCategory.count {
            fetchRequest.predicate = NSPredicate(format: "category == %@", ClothesArray.sharedDataSource().ClothesCategory[i])
            
            if let fetchResults = try? coreDataStack.context.fetch(fetchRequest) as! [Item] {
                numItemsForCategories.append(fetchResults.count)
            }
        }
    }
    
    @IBAction func addItemClicked(_ sender: Any) {
        //launch the photo activity: first step in adding item
        print("addItemClicked()!!!")
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.allowsEditing = true
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: imagePicker.sourceType)!
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension CategoryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        if mediaType == (kUTTypeImage as String) {
            itemImage = info[UIImagePickerControllerEditedImage] as? UIImage
            print(itemImage==nil)
            
        } else{
            //a video was taken
            print("no photo was taken")
        }
        dismiss(animated: true) {
            self.navigationItem.title = "Choose a category for the item"
            CategoryViewController.isAddingItem = true
            self.tableView.reloadData()
        }
    }
    
}
