//
//  OrderTableViewController.swift.swift
//  agilemark
//
//  Created by _ on 20/12/2021.
//

import Foundation
import UIKit
import Resolver
class OrderTableViewController : UITableViewController {
    @Injected
    var appDelegate : AppDelegate
    var items : [LogFoodItem] = []
    var getLanguageWithKey : ((_ key: String) -> String)!
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        self.tableView.register(OrderItem.nib(), forCellReuseIdentifier: OrderItem.id)
        
    }
}
extension OrderTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        items.count
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
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderItem.id, for: indexPath) as? OrderItem else {
            fatalError("Unable to dequeue OrderItem")
        }
        let item = items[indexPath.section]
        let money = (Double(item.totalMoney!)/100)
        let moneyDouble = Double(money)
        let moneyString = moneyDouble.toRestaurantMoney(setting: appDelegate.currentRestaurant!.getSetting())
        cell.money.text = moneyString
        var d = item.parseDate()
        cell.timeContent.text = d.convertDateToString(format: "MM/dd HH:mm",locale: true).replacingOccurrences(of: " ", with: " - ")
        cell.cancelerContent.text = item.forEmployee
        cell.ordererContent.text = item.employee
        cell.tableContent.text = item.tableName
        cell.orderName.text = item.foodName
        cell.quantity.text = "x" + String((Int)(item.quantity!))
        
        // localize
        cell.timeTitle.text = getLanguageWithKey("time")
        cell.cancelerTitle.text = getLanguageWithKey("canceler")
        cell.ordererTitle.text = getLanguageWithKey("orderer")
        cell.tableTitle.text = getLanguageWithKey("table")
        return cell
    }
}




