//
//  RevenueHeaderItem.swift
//  remview
//
//  Created by Bui Si Quan on 24/04/2022.
//

import UIKit

class RevenueHeaderItem: UICollectionReusableView {
    @IBOutlet weak var name : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static let id = "RevenueHeaderItem"
    
    static func nib()->UINib{
        UINib(nibName: "RevenueHeaderItem", bundle: nil)
    }
    
}
