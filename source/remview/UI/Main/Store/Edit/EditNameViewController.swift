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

class EditNameViewController: BaseViewController{
    
    var callback : ((_ name:String)->Void)!
    var cancelCallback : (()->Void)!
    var restaurantName : String?
    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var confirm: UILabel!
    @IBOutlet weak var cancel: UILabel!

    
    override func reloadData() {
        message.text = getLanguageWithKey(key: "edit_msg")
        confirm.text = getLanguageWithKey(key: "yes")
        cancel.text = getLanguageWithKey(key: "no")
    }
    
    @IBAction func close(_ sender: Any) {
        cancelCallback()
        dismiss(animated: true)
    }
    @IBAction func sendBtnClick(_ sender: Any) {
        if name.text!.isEmpty {
            makeToast(title: nil, msg: "Please input your name")
        } else {
            callback(name.text!)
        }
    }
    override func setup() {
        super.setup()
        name.text = restaurantName
        self.registerDismissKeyboardOnTapOutSide()
    }
    override func registerKeyboardListener() {
        // remove kb listener
    }
}
