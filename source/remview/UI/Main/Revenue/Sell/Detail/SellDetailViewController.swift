//
//  SellDetailViewController.swift
//  remview
//
//  Created by Bui Si Quan on 28/04/2022.
//

import Foundation
import UIKit

class SellDetailViewController : BaseViewController {
    static var DELIM_1 = "¶*¶";
    static var DELIM_2 = "█";
    static var DELIM_3 = "Ө";
    static var DELIM_4 = "≡";
    static var DELIM_5 = "≠";
    static var DELIM_6 = "------------------------------";
    
    @IBOutlet weak var restaurantName : UILabel!
    var sellItem : BillingItemUnit!
    
    var sellDetailTableViewController:SellDetailTableViewController!
    var viewmodel = SellViewModel()
    var foodItems : [FoodItem] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SellDetailTableViewController" {
            if let vc = segue.destination as? SellDetailTableViewController {
                self.sellDetailTableViewController = vc
                self.setupSellDetail()
                self.sellDetailTableViewController.detail = sellItem
                self.sellDetailTableViewController.foodItems = self.foodItems
                self.sellDetailTableViewController.getLanguageWithKey = self.getLanguageWithKey(key:)
            }
        }
    }
    
    func setupSellDetail(){
        var allRecords = sellItem.monAn?.components(separatedBy: SellDetailViewController.DELIM_1) ?? []
        allRecords.removeAll{$0.isEmpty}
        if !allRecords.isEmpty {
            var foodItem : FoodItem
            for i in 0...allRecords.count-1 {
                if !allRecords.isEmpty && !allRecords[i].elementsEqual(SellDetailViewController.DELIM_6)  {
                    foodItem = FoodItem()
                    let recordDetail = allRecords[i].components(separatedBy: SellDetailViewController.DELIM_2)
                    let foodDetail = recordDetail[1].components(separatedBy: SellDetailViewController.DELIM_3)
                    foodItem.amount = Int(foodDetail[0])
                    foodItem.name = foodDetail[1]
                    foodItem.price = foodDetail[2].restaurantStringToDouble(setting:(appDelegate.currentRestaurant?.getSetting())!)
                    foodItem.foodType = FoodItem.FOOD_TYPE_FOOD
                    self.foodItems.append(foodItem)
                    
                    if foodDetail.count>5 {
                        self.parserBeilager(b: foodDetail[5])
                    }
                }
                
                
            }
        }
        
        
    }
    func parserBeilager(b:String){
        let beilageFoods = b.components(separatedBy: SellDetailViewController.DELIM_4)
        if beilageFoods.count > 0 {
            var beilage : FoodItem
            for i in 0...beilageFoods.count-1 {
                beilage = FoodItem()
                beilage.foodType = FoodItem.FOOD_TYPE_BEILAGE
                if !beilageFoods[i].isEmpty{
                    let beilageDetail = beilageFoods[i].components(separatedBy: SellDetailViewController.DELIM_5)
                    beilage.name = beilageDetail[0]
                    beilage.price = beilageDetail[2].restaurantStringToDouble(setting: (appDelegate.currentRestaurant?.getSetting())!)
                    self.foodItems.append(beilage)
                }
            }
        }
    }
    
    override func setup() {
        restaurantName.text = appDelegate.currentRestaurant?.name
    }
    
    @IBAction func back(_ sender : Any){
        dismiss(animated: true, completion: nil)
    }

}
