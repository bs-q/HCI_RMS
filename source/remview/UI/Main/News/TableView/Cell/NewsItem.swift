//
//  NewsItem.swift
//  remview
//
//  Created by Bui Si Quan on 25/04/2022.
//

import UIKit

class NewsItem: UITableViewCell {
    var item : NewsResponse!
    var callback : ((_ item:NewsResponse)->Void)!

    @IBOutlet weak var thumbnail : UIImageView!
    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var root : UIView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        root.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
    @objc func tap(){
        callback(item)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static let id = "NewsItem"
    
    static func nib()->UINib{
        UINib(nibName: "NewsItem", bundle: nil)
    }
    
}
