//
//  OutfitsTableViewController.swift
//  Project333
//
//  Created by Eric Wei on 2017-04-04.
//  Copyright © 2017 EricWei. All rights reserved.
//

import Foundation
import UIKit
import CoreData

//SAVED OUTFITS!
class OutfitsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var outfitsTableView: UITableView!
    var coreDataStack: CoreDataStack!
    var outfits = [Outfit]()
    var selectedOutfit = [Item]()
    
    override func viewWillAppear(_ animated: Bool) {
        outfits.removeAll()
        selectedOutfit.removeAll()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Outfit")
        var sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = NSPredicate(format: "name != %@", "today")
        
        if let fetchResults = try? coreDataStack.context.fetch(fetchRequest) as! [Outfit] {
            self.outfits = fetchResults
            // print("OutfitsTableViewController!!  number of Outfits in core data = \(fetchResults.count)")
        }
        outfitsTableView.reloadData()
    }
    
    override func viewDidLoad() {
        outfitsTableView.delegate = self
        outfitsTableView.dataSource = self
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        coreDataStack = delegate.stack
    }
    
    //tableview methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("OutfitsTableViewController!!  number of Outfits in core data = \(self.outfits.count)")
        return self.outfits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("savedOutfits table VC  cellForRowAt()")
        let cell = tableView.dequeueReusableCell(withIdentifier: "OutfitCell")!
        cell.textLabel?.text = self.outfits[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getItemsForRowSelected(rowNumber: indexPath.row)
        
        performSegue(withIdentifier: "GoSavedOutfitSegue", sender: self)
    }
    
    func getItemsForRowSelected(rowNumber: Int) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Outfit")
        fetchRequest.predicate = NSPredicate(format: "name == %@", outfits[rowNumber].name!)
        
        if let fetchResults = try? coreDataStack.context.fetch(fetchRequest) as! [Outfit] {
            let outfit = fetchResults[0]
            if outfit.item1 != nil {
                selectedOutfit.append(outfit.item1!)
            }
            if outfit.item2 != nil {
                selectedOutfit.append(outfit.item2!)
            }
            if outfit.item3 != nil {
                selectedOutfit.append(outfit.item3!)
            }
            if outfit.item4 != nil {
                selectedOutfit.append(outfit.item4!)
            }
            if outfit.item5 != nil {
                selectedOutfit.append(outfit.item5!)
            }
            if outfit.item6 != nil {
                selectedOutfit.append(outfit.item6!)
            }
            if outfit.item7 != nil {
                selectedOutfit.append(outfit.item7!)
            }
            if outfit.item8 != nil {
                selectedOutfit.append(outfit.item8!)
            }
            if outfit.item9 != nil {
                selectedOutfit.append(outfit.item9!)
            }
            if outfit.item10 != nil {
                selectedOutfit.append(outfit.item10!)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "FromSavedOutfitsSegue":
                let controller = segue.destination as! CustomNavController
                controller.fromNewOutfitButton = false
            case "GoSavedOutfitSegue":
                let controller = segue.destination as! SavedOutfitViewController
                controller.items = selectedOutfit
            default:
                print("wrong segue ID")
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
