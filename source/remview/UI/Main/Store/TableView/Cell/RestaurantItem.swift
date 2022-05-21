//
//  RestaurantItem.swift
//  remview
//
//  Created by Bui Si Quan on 21/04/2022.
//

import UIKit

class RestaurantItem: UITableViewCell {
    
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var modifyDate : UILabel!
    @IBOutlet weak var root : UIView!
    var restaurant : Restaurant!
    var clickCallback : ((_ restaurant : Restaurant)->Void)!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        root.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        
    }
    @objc func tap(){
        clickCallback(restaurant)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static let id = "RestaurantItem"
    
    static func nib()->UINib{
        UINib(nibName: "RestaurantItem", bundle: nil)
    }
    
}
