//
//  PermissionTableViewController.swift.swift
//  agilemark
//
//  Created by _ on 20/12/2021.
//

import Foundation
import UIKit
class PermissionTableViewController : UITableViewController {
    
    var clickCallback : ((_ permission : Permission)->Void)!
    var getLanguageWithKey : ((_ key: String) -> String)!
    @IBOutlet var mTableView: UITableView!
    var items : [Permission] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        self.tableView.register(PermissionItem.nib(), forCellReuseIdentifier: PermissionItem.id)
        
    }
}
extension PermissionTableViewController {
    
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
            return 10
        }
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var v = UIView()
        v.backgroundColor = .clear
        return v
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PermissionItem.id, for: indexPath) as? PermissionItem else {
            fatalError("Unable to dequeue PermissionItem")
        }
        cell.permission = items[indexPath.section]
        cell.name.text = cell.permission.name
        cell.clickCallback = clickCallback
        return cell
    }
}




