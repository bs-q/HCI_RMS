//
//  BaseViewModel.swift
//  MQRcode
//
//  Created by Nguyen Hoang on 10/16/20.
//

import UIKit
import RxSwift
import Resolver
import Alamofire

class BaseViewModel: NSObject {
    let disposeBag = DisposeBag()
    
    @Injected
    var appCofig: AppConfiguration
    
    @Injected
    var homeService : HomeService
    
    func deviceId()->String {
        return UIDevice.current.identifierForVendor?.uuidString ?? "*emulator*"
    }
}
