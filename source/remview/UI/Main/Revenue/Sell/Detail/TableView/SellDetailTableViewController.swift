//
//  SellTableViewController.swift.swift
//  agilemark
//
//  Created by _ on 20/12/2021.
//

import Foundation
import UIKit
import Resolver
class SellDetailTableViewController : UITableViewController {
    
    @Injected
    var appDelegate : AppDelegate
    
    var detail : BillingItemUnit?
    
    var foodItems : [FoodItem] = []
    var getLanguageWithKey : ((_ key: String) -> String)!


    @IBOutlet var mTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        self.tableView.register(SellDetailItem.nib(), forCellReuseIdentifier: SellDetailItem.id)
        self.tableView.register(SellDetailHeaderItem.nib(), forCellReuseIdentifier: SellDetailHeaderItem.id)
        self.tableView.register(SellDetailFooterItem.nib(), forCellReuseIdentifier: SellDetailFooterItem.id)

    }
}
extension SellDetailTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        foodItems.count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = self.tableView.dequeueReusableCell(withIdentifier: SellDetailHeaderItem.id) as! SellDetailHeaderItem
        header.contentView.roundCorners(corners: [.layerMinXMinYCorner,.layerMaxXMinYCorner], radius: 10)
        header.idTitle.text = "#" + String(detail?.billNumber ?? 0)
        header.idContent.text = detail?.paymentMethod
        header.timeContent.text = detail?.date
        header.employeeContent.text = detail?.employee
        header.tableContent.text = detail?.tableName
        header.tableTypeContent.text = detail?.inOrOut
        
        // localize
        header.timeTitle.text = getLanguageWithKey("time")
        header.employeeTitle.text = getLanguageWithKey("employee")
        header.tableTitle.text = getLanguageWithKey("table")
        header.tableTypeTitle.text = getLanguageWithKey("tabletype")
        return header
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = self.tableView.dequeueReusableCell(withIdentifier: SellDetailFooterItem.id) as! SellDetailFooterItem
        footer.root.roundCorners(corners: [.layerMinXMaxYCorner,.layerMaxXMaxYCorner], radius: 10)
        
        let pricePrint = Double((detail?.totalMoney)!/100)
        footer.totalContent.text = pricePrint.toRestaurantMoney(setting: (appDelegate.currentRestaurant?.getSetting())!)
        footer.totalTitle.text = getLanguageWithKey("totalmoney")
        return footer
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SellDetailItem.id, for: indexPath) as? SellDetailItem else {
            fatalError("Unable to dequeue SellDetailItem")
        }
        if indexPath.row != foodItems.count-1 {
            cell.line.isHidden = false
        }
        let item = foodItems[indexPath.row]
        cell.orderName.text = item.name
        if item.foodType == FoodItem.FOOD_TYPE_FOOD {
            cell.quantity.text = "x" + String(item.amount!)
        } else {
            cell.quantity.text = ""
        }
        if item.price != nil && item.price != 0 {
            cell.money.text = item.price?.toRestaurantMoney(setting: (appDelegate.currentRestaurant?.getSetting())!)
        } else {
            cell.money.text = ""
        }
        return cell
    }
    
}




