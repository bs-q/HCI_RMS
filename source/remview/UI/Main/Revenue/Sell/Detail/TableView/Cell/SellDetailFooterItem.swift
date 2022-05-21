//
//  SellDetailFooterItem.swift
//  remview
//
//  Created by Bui Si Quan on 30/04/2022.
//

import UIKit

class SellDetailFooterItem: UITableViewCell {
    @IBOutlet weak var totalTitle : UILabel!
    @IBOutlet weak var totalContent : UILabel!
    @IBOutlet weak var dottedLine : UIView!
    @IBOutlet weak var root : UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static let id = "SellDetailFooterItem"
    
    static func nib()->UINib{
        UINib(nibName: "SellDetailFooterItem", bundle: nil)
    }
}
