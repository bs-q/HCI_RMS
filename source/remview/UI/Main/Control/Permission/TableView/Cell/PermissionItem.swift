//
//  PermissionItem.swift
//  remview
//
//  Created by Bui Si Quan on 12/05/2022.
//

import UIKit

class PermissionItem: UITableViewCell {
    
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var root : UIView!
    var permission : Permission!
    var clickCallback : ((_ permission : Permission)->Void)!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        root.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        
    }
    @objc func tap(){
        clickCallback(permission)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static let id = "PermissionItem"
    
    static func nib()->UINib{
        UINib(nibName: "PermissionItem", bundle: nil)
    }
}
