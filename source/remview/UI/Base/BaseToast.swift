//
//  BaseToast.swift
//  MQRcode
//
//  Created by Nguyen Hoang on 10/16/20.
//
import Foundation
import UIKit
class BaseToast{
    
    static let shareIntanse = BaseToast()
    var isShowing = false
    
    func showToast(mqError: String,isForceShowing:Bool = false ){
        
        if isForceShowing || !isShowing {
            
            BaseToast.shareIntanse.isShowing = true
            ScreenCoordinator.topViewController()?.makeToast(title: "",msg: mqError)
        }
    }
}
