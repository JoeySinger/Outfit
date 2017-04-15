//
//  SubcategoryViewController.swift
//  Project333
//
//  Created by Eric Wei on 2017-03-30.
//  Copyright © 2017 EricWei. All rights reserved.
//

import Foundation
import UIKit

class SubcategoryViewController: UITableViewController {
    
    var coreDataStack: CoreDataStack!
    var subcategoryItems = [String]()
    var category: String!
    var itemImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        coreDataStack = delegate.stack
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("length of subcategory array = \(subcategoryItems.count)")
    }
    
    //tableview methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subcategoryItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubcategoryCell")!
        cell.textLabel?.text = subcategoryItems[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = UIImagePNGRepresentation(itemImage) as NSData!
        let item = Item(category: category, subCategory: subcategoryItems[indexPath.row], imageData: data as! Data, context: coreDataStack.context)
        self.coreDataStack.save()
        
        CategoryViewController.isAddingItem = false
        print("item saved successfully")
        self.navigationController?.popViewController(animated: true)
    }
}
