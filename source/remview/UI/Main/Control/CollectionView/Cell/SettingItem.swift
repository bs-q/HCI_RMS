//
//  SettingItem.swift
//  remview
//
//  Created by Bui Si Quan on 02/05/2022.
//

import UIKit

class SettingItem: UICollectionViewCell {
    var item : SettingItemType!
    var callback : ((_ item:SettingItemType)->Void)!
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
    static let id = "SettingItem"
    
    static func nib()->UINib{
        UINib(nibName: "SettingItem", bundle: nil)
    }
}
