//
//  RevenueDetailItem.swift
//  remview
//
//  Created by Bui Si Quan on 26/04/2022.
//

import UIKit

class EmployeeDetailItem: UICollectionViewCell {
    
    @IBOutlet weak var root: UIView!
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static let id = "EmployeeDetailItem"
    
    static func nib()->UINib{
        UINib(nibName: "EmployeeDetailItem", bundle: nil)
    }
}
