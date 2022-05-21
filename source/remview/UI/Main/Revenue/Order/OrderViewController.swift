//
//  OrderViewController.swift
//  remview
//
//  Created by Bui Si Quan on 28/04/2022.
//

import Foundation
import UIKit

class OrderViewController : BaseViewController {
    
    @IBOutlet weak var restaurantName : UILabel!
    @IBOutlet weak var orderList : UILabel!

    
    var orderTableViewController:OrderTableViewController!
    var viewmodel = SellViewModel()
    var items : [LogFoodItem]!
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OrderTableViewController" {
            if let vc = segue.destination as? OrderTableViewController {
                self.orderTableViewController = vc
                self.orderTableViewController.items = self.items
                self.orderTableViewController.getLanguageWithKey = self.getLanguageWithKey(key:)
            }
        }
    }
    
    override func reloadData() {
        orderList.text = getLanguageWithKey(key: "orderlist")
    }
    
    @IBAction func back(_ sender : Any){
        dismiss(animated: true, completion: nil)
    }
    
    override func setup() {
        super.setup()
        restaurantName.text = appDelegate.currentRestaurant?.name
    }
}
