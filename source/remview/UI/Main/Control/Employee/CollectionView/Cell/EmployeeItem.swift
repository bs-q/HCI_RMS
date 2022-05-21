//
//  EmployeeItem.swift
//  remview
//
//  Created by Bui Si Quan on 02/05/2022.
//

import UIKit

class EmployeeItem: UICollectionViewCell {
    var item : EmployeeObject!
    var callback : ((_ item:EmployeeObject)->Void)!
    @IBOutlet weak var root : UIView!
    @IBOutlet weak var type : UILabel!
    @IBOutlet weak var money : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        root.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
    @objc func tap(){
        callback(item)
    }
    static let id = "EmployeeItem"
    
    static func nib()->UINib{
        UINib(nibName: "EmployeeItem", bundle: nil)
    }
}
