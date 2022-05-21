//
//  SellTableViewController.swift.swift
//  agilemark
//
//  Created by _ on 20/12/2021.
//

import Foundation
import UIKit
import Resolver
class SellTableViewController : UITableViewController {
    @Injected
    var appDelegate : AppDelegate
    var selectSellCallback : ((_ sellItem : BillingItemUnit)->Void)!
    var getLanguageWithKey : ((_ key: String) -> String)!

    @IBOutlet var mTableView: UITableView!
    var sellList : [BillingItemUnit] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        self.tableView.register(SellItem.nib(), forCellReuseIdentifier: SellItem.id)
        
    }
}
extension SellTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        sellList.count
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 5
        }
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var v = UIView()
        v.backgroundColor = .clear
        return v
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SellItem.id, for: indexPath) as? SellItem else {
            fatalError("Unable to dequeue SellItem")
        }
        cell.item = sellList[indexPath.section]
        cell.idContent.text = String(cell.item.billNumber!)
        cell.timeContent.text = cell.item.date
        cell.tableContent.text = cell.item.tableName
        let money = (Double(cell.item.totalMoney!) - (Double(cell.item.totalMoney!)*cell.item.percent!/100))/100
        let moneyDouble = Double(money)
        let moneyString = moneyDouble.toRestaurantMoney(setting: appDelegate.currentRestaurant!.getSetting())
        cell.totalContent.text = moneyString
        cell.callback = selectSellCallback
        
        // localize
        cell.idTitle.text = getLanguageWithKey("ID")
        cell.timeTitle.text = getLanguageWithKey("time")
        cell.tableTitle.text = getLanguageWithKey("tablenumber")
        cell.totalTitle.text = getLanguageWithKey("total")
        
        return cell
    }
    
}




