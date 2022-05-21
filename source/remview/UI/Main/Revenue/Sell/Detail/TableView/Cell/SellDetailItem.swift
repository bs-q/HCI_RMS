//
//  SellDetailItem.swift
//  remview
//
//  Created by Bui Si Quan on 30/04/2022.
//

import UIKit

class SellDetailItem: UITableViewCell {
    @IBOutlet weak var orderName : UILabel!
    @IBOutlet weak var quantity : UILabel!
    @IBOutlet weak var money : UILabel!
    @IBOutlet weak var line : UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static let id = "SellDetailItem"
    
    static func nib()->UINib{
        UINib(nibName: "SellDetailItem", bundle: nil)
    }
    
}
