//
//  EditNameViewController.swift.swift
//  agilemark
//
//  Created by _ on 23/12/2021.
//

import Foundation
import UIKit
import Resolver
import RxSwift
import ObjectMapper
import WebKit

class StoreActiveViewController: BaseViewController{
    
    @IBOutlet weak var message : UILabel!
    @IBOutlet weak var cancel : UILabel!
    @IBOutlet weak var confirm : UILabel!
    
    var callback : (()->Void)!
    var restaurantName : String?
    
    override func reloadData() {
        message.text = getLanguageWithKey(key: "active_msg")
        cancel.text = getLanguageWithKey(key: "close")
        confirm.text = getLanguageWithKey(key: "check")
    }
    
    @IBAction func close(_ sender: Any) {
        appDelegate.currentRestaurant = nil
        dismiss(animated: true)
    }
    @IBAction func sendBtnClick(_ sender: Any) {
        callback()
    }
    
}
