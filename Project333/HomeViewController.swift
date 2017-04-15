//
//  HomeViewController.swift
//  Project333
//
//  Created by Eric Wei on 2017-04-01.
//  Copyright © 2017 EricWei. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SystemConfiguration

class HomeViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var coreDataStack: CoreDataStack!
    var todaysOutfit = [Item]()
    
    override func viewWillAppear(_ animated: Bool) {
        todaysOutfit.removeAll()
        loadingIndicator.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let delegate = UIApplication.shared.delegate as! AppDelegate
        coreDataStack = delegate.stack
        searchBar.delegate = self
        
    }
    
    @IBAction func newOutfitButtonClicked(_ sender: Any) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Outfit")
        fetchRequest.predicate = NSPredicate(format: "name== %@", "today")
        
        if let fetchResults = try? coreDataStack.context.fetch(fetchRequest) as! [Outfit] {
            print("number of Outfits in core data = \(fetchResults.count)")
            if fetchResults.count == 1{
                let outfit = fetchResults[0]
                if outfit.item1 != nil {
                    todaysOutfit.append(outfit.item1!)
                }
                if outfit.item2 != nil {
                    todaysOutfit.append(outfit.item2!)
                }
                if outfit.item3 != nil {
                    todaysOutfit.append(outfit.item3!)
                }
                if outfit.item4 != nil {
                    todaysOutfit.append(outfit.item4!)
                }
                if outfit.item5 != nil {
                    todaysOutfit.append(outfit.item5!)
                }
                if outfit.item6 != nil {
                    todaysOutfit.append(outfit.item6!)
                }
                if outfit.item7 != nil {
                    todaysOutfit.append(outfit.item7!)
                }
                if outfit.item8 != nil {
                    todaysOutfit.append(outfit.item8!)
                }
                if outfit.item9 != nil {
                    todaysOutfit.append(outfit.item9!)
                }
                if outfit.item10 != nil {
                    todaysOutfit.append(outfit.item10!)
                }
                
                performSegue(withIdentifier: "GoTodayOutfitSegue", sender: self)
            }
        }
        performSegue(withIdentifier: "FromNewOutFitSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
            switch identifier {
            case "FromNewOutFitSegue":
                let controller = segue.destination as! CustomNavController
                controller.fromNewOutfitButton = true
            case "GoTodayOutfitSegue":
                let controller = segue.destination as! SavedOutfitViewController
                print("\(todaysOutfit.count) todays outfits")
                controller.items = todaysOutfit
            default:
                print("")
            }
        }
    }
    
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if isInternetAvailable() {
            self.weatherLabel.isHidden = true
            self.loadingIndicator.isHidden = false
            loadingIndicator.startAnimating()
            
            WeatherClient.sharedInstance().getWeatherResponse(cityName: self.searchBar.text!) { (temperature, locationName, error) in
                DispatchQueue.main.async {
                    self.weatherLabel.isHidden = false
                    if (error != nil) {
                        self.weatherLabel.text = "location don't exist"
                    } else{
                        self.weatherLabel.text = "\(locationName): \(temperature-273.15) C"
                    }
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.isHidden = true
                }
            }
        } else{
            let alert = UIAlertController(title: "", message: "No Internet Connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
