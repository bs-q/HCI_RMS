//
//  StoreTableViewController.swift.swift
//  agilemark
//
//  Created by _ on 20/12/2021.
//

import Foundation
import UIKit
class StoreTableViewController : UITableViewController {
    
    var deleteRestaurantCallback : ((_ restaurant : Restaurant)->Void)!
    var selectRestaurantCallback : ((_ restaurant : Restaurant)->Void)!
    var getLanguageWithKey : ((_ key: String) -> String)!
    @IBOutlet var mTableView: UITableView!
    var restaurantList : [Restaurant] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        self.tableView.register(RestaurantItem.nib(), forCellReuseIdentifier: RestaurantItem.id)
        
    }
}
extension StoreTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        restaurantList.count
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 10
        }
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var v = UIView()
        v.backgroundColor = .clear
        return v
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantItem.id, for: indexPath) as? RestaurantItem else {
            fatalError("Unable to dequeue RestaurantItem")
        }
        cell.restaurant = restaurantList[indexPath.section]
        cell.name.text = restaurantList[indexPath.section].name
        cell.modifyDate.text = getLanguageWithKey("lastvisited") + " " +  (restaurantList[indexPath.section].lastAccessDate?.convertDateToString(format: "dd.MM.YYYY HH.mm.ss"))!
        cell.clickCallback = selectRestaurantCallback
        return cell
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Trash action
               let trash = UIContextualAction(style: .destructive,
                                              title: nil) { [weak self] (action, view, completionHandler) in
                   debugPrint("* delete")
                   completionHandler(true)
                   self!.deleteRestaurantCallback(self!.restaurantList[indexPath.section])
               }
        trash.image = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30)).image { _ in
            UIImage(named: "trash")?.draw(in: CGRect(x: 0, y: 0, width: 30, height: 30))
        }
        
               trash.backgroundColor = .systemRed
        
        let configuration = UISwipeActionsConfiguration(actions: [trash])
                // If you do not want an action to run with a full swipe
                configuration.performsFirstActionWithFullSwipe = false
                return configuration
    }
}




