//
//  SellDetailHeaderItem.swift
//  remview
//
//  Created by Bui Si Quan on 30/04/2022.
//

import UIKit

class SellDetailHeaderItem: UITableViewCell {
    @IBOutlet weak var idTitle : UILabel!
    @IBOutlet weak var idContent : UILabel!
    @IBOutlet weak var timeTitle : UILabel!
    @IBOutlet weak var timeContent : UILabel!
    @IBOutlet weak var employeeTitle : UILabel!
    @IBOutlet weak var employeeContent : UILabel!
    @IBOutlet weak var tableTitle : UILabel!
    @IBOutlet weak var tableContent : UILabel!
    @IBOutlet weak var tableTypeTitle : UILabel!
    @IBOutlet weak var tableTypeContent : UILabel!
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
    
    static let id = "SellDetailHeaderItem"
    
    static func nib()->UINib{
        UINib(nibName: "SellDetailHeaderItem", bundle: nil)
    }
}
