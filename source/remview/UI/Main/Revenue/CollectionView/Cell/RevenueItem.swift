//
//  RevenueItem.swift
//  remview
//
//  Created by Bui Si Quan on 24/04/2022.
//

import UIKit

class RevenueItem: UICollectionViewCell {
    var item : RevenueItemType!
    var callback : ((_ item:RevenueItemType)->Void)!
    @IBOutlet weak var root : UIView!
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var image : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        root.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
    @objc func tap(){
        callback(item)
    }
    static let id = "RevenueItem"
    
    static func nib()->UINib{
        UINib(nibName: "RevenueItem", bundle: nil)
    }

}
