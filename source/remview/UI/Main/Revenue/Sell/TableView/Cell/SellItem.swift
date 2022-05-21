//
//  SellItem.swift
//  remview
//
//  Created by Bui Si Quan on 28/04/2022.
//

import UIKit

class SellItem: UITableViewCell {
    // id
    @IBOutlet weak var idTitle : UILabel!
    @IBOutlet weak var idContent : UILabel!
    
    // time
    @IBOutlet weak var timeTitle : UILabel!
    @IBOutlet weak var timeContent : UILabel!
    // table
    @IBOutlet weak var tableTitle : UILabel!
    @IBOutlet weak var tableContent : UILabel!
    // total
    @IBOutlet weak var totalTitle : UILabel!
    @IBOutlet weak var totalContent : UILabel!
    
    @IBOutlet weak var root : UIView!
    
    var item : BillingItemUnit!
    
    var callback : ((_ item : BillingItemUnit)->Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        root.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sellItemCallback)))
    }
    @objc func sellItemCallback(){
        callback(item)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static let id = "SellItem"
    
    static func nib()->UINib{
        UINib(nibName: "SellItem", bundle: nil)
    }
    
}
