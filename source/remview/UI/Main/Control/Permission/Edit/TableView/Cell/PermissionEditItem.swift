//
//  PermissionEditItem.swift
//  remview
//
//  Created by Bui Si Quan on 13/05/2022.
//

import UIKit

class PermissionEditItem: UITableViewCell {
    
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var root : UIView!
    @IBOutlet weak var check : UIImageView!
    var index : Int!
    var permission : PermissionEditTableViewController.PermissionToggleItem!
    var clickCallback : ((_ permission : PermissionEditTableViewController.PermissionToggleItem,_ index:Int)->Void)!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        root.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        
    }
    @objc func tap(){
        clickCallback(permission,index)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static let id = "PermissionEditItem"
    
    static func nib()->UINib{
        UINib(nibName: "PermissionEditItem", bundle: nil)
    }
    
}
