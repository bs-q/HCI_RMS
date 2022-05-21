//
//  PermissionEditTableViewController.swift.swift
//  agilemark
//
//  Created by _ on 20/12/2021.
//

import Foundation
import UIKit
class PermissionEditTableViewController : UITableViewController {
    var getLanguageWithKey : ((_ key: String) -> String)!

    class PermissionToggleItem{
        var base : Int?
        var name : String?
        var check = false
        
        init(base:Int,name:String){
            self.base = base
            self.name = name
        }
    }
    func createPermissionList(){
        let four = PermissionToggleItem(base:4,name:"four");
        let sixfour = PermissionToggleItem(base:64,name:"sixfour");
        let onetwoeight = PermissionToggleItem(base:128,name:"onetwoeight");
        let twofivesix = PermissionToggleItem(base:256,name:"twofivesix");
        let fiveonetwo = PermissionToggleItem(base:512,name:"fiveonetwo");
        let onezerotwofour = PermissionToggleItem(base:1024,name:"onezerotwofour");
        let two = PermissionToggleItem(base:2,name:"two");
        let twozerofoureight = PermissionToggleItem(base:2048,name:"twozerofoureight");
        let threetwo = PermissionToggleItem(base:32,name:"threetwo");
        let fourzeroninesix = PermissionToggleItem(base:4096,name:"fourzeroninesix");
        let eight = PermissionToggleItem(base:8,name:"eight");
        let onesix = PermissionToggleItem(base:16,name:"onesix");
        let one = PermissionToggleItem(base:1,name:"one");
        
        permissionToggleItemList.append(four);
        permissionToggleItemList.append(sixfour);
        permissionToggleItemList.append(onetwoeight);
        permissionToggleItemList.append(one);
        permissionToggleItemList.append(twofivesix);
        permissionToggleItemList.append(fiveonetwo);
        permissionToggleItemList.append(onezerotwofour);
        permissionToggleItemList.append(two);
        permissionToggleItemList.append(twozerofoureight);
        permissionToggleItemList.append(threetwo);
        permissionToggleItemList.append(fourzeroninesix);
        permissionToggleItemList.append(eight);
        permissionToggleItemList.append(onesix);
        
        for i in permissionToggleItemList {
            if permission.contains(i.base!){
                i.check = true
            }
        }
        
    }
    func createPermission(range:Int){
        var v : [Int] = []
        var x = range
        while x > 0 {
            v.append(x%2)
            x = x/2
        }
        for (index,value) in v.enumerated() {
            if value == 1 {
                permission.insert(Int(pow(2, Double(index))))
            }
        }
    }
    var permissionToggleItemList : [PermissionToggleItem] = []
    var permission : Set<Int> = Set()
    @IBOutlet var mTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        self.tableView.register(PermissionEditItem.nib(), forCellReuseIdentifier: PermissionEditItem.id)
        
    }
}
extension PermissionEditTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        permissionToggleItemList.count
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
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PermissionEditItem.id, for: indexPath) as? PermissionEditItem else {
            fatalError("Unable to dequeue PermissionEditItem")
        }
        cell.permission = permissionToggleItemList[indexPath.section]
        
        cell.index = indexPath.section
        cell.name.text = getLanguageWithKey(cell.permission.name!)
        cell.check.isHidden = !cell.permission.check
        cell.clickCallback = clickCallback
        return cell
    }
    func clickCallback( permission : PermissionToggleItem,index:Int) {
        permission.check = !permission.check
        tableView.reloadData()
    }
}




