//
//  OrderItem.swift
//  remview
//
//  Created by Bui Si Quan on 02/05/2022.
//

import UIKit

class OrderItem: UITableViewCell {
    // canceler
    @IBOutlet weak var cancelerTitle : UILabel!
    @IBOutlet weak var cancelerContent : UILabel!
    // time
    @IBOutlet weak var timeTitle : UILabel!
    @IBOutlet weak var timeContent : UILabel!
    // table
    @IBOutlet weak var tableTitle : UILabel!
    @IBOutlet weak var tableContent : UILabel!
    // orderer
    @IBOutlet weak var ordererTitle : UILabel!
    @IBOutlet weak var ordererContent : UILabel!
    
    @IBOutlet weak var orderName : UILabel!
    @IBOutlet weak var quantity : UILabel!
    @IBOutlet weak var money : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static let id = "OrderItem"
    
    static func nib()->UINib{
        UINib(nibName: "OrderItem", bundle: nil)
    }
    
}
