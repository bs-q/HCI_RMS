//
//  SellViewController.swift
//  remview
//
//  Created by Bui Si Quan on 28/04/2022.
//

import Foundation
import UIKit

class SellViewController : BaseViewController {
    
    @IBOutlet weak var restaurantName : UILabel!
    @IBOutlet weak var sales: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var totalTitle: UILabel!

    
    var sellTableViewController:SellTableViewController!
    var viewmodel = SellViewModel()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SellTableViewController" {
            if let vc = segue.destination as? SellTableViewController {
                self.sellTableViewController = vc
                self.sellTableViewController.sellList = viewmodel.item
                self.sellTableViewController.selectSellCallback = sellItemCallback(sellItem:)
                self.sellTableViewController.getLanguageWithKey = self.getLanguageWithKey(key:)
            }
        }
    }
    
    @IBAction func back(_ sender : Any){
        dismiss(animated: true, completion: nil)
    }
    override func reloadData() {
        sales.text = getLanguageWithKey(key: "sellinglist")
        totalTitle.text = getLanguageWithKey(key: "totalmoney")
    }
    override func setup() {
        super.setup()
        updateSell()
    }
    func sellItemCallback(sellItem:BillingItemUnit){
        debug(sellItem)
        navigateToSellDetail(sellItem: sellItem)
    }
    func navigateToSellDetail(sellItem:BillingItemUnit){
        let storyBoard: UIStoryboard = UIStoryboard(name: "sell", bundle:  nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SellDetailViewController") as! SellDetailViewController
        vc.modalPresentationStyle = .fullScreen
        vc.sellItem = sellItem
        self.present(vc, animated: true)
    }
    func updateSell(){
        restaurantName.text = appDelegate.currentRestaurant?.name
        total.text =  viewmodel.item.reduce(0, {
            let money = (Double($1.totalMoney!) - (Double($1.totalMoney!)*$1.percent!/100))/100
            let moneyDouble = Double(money)
            return $0 + moneyDouble
    
        }).toRestaurantMoney(setting: appDelegate.currentRestaurant!.getSetting())
    }

}
