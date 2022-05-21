//
//  HomeViewModel.swift
//  agilemark
//
//  Created by _ on 20/12/2021.
//

import Foundation
import Foundation
import UIKit
import Resolver
import SwiftUI
import RxSwift
import RxRelay
import RxCocoa

class StoreViewModel: BaseViewModel {
    
    @Injected
    var restaurantDao : RestaurantDao
    
    @Injected
    var appDelegate : AppDelegate
    
    var restaurantCallback : RestaurantProtocol?
    
    var token : String?
    var posName : String?
    var posId : String?
    var isActive : Bool?
    var restaurantList : [Restaurant] = []
    override init() {
        super.init()
        getRestaurantList()
    }
    func getRestaurantList(){
        self.restaurantDao.findAll().subscribe(onNext: {result in
            debug("get news restaurant list")
            self.restaurantList = result ?? []
            self.restaurantCallback?.newRestaurantLists(l:self.restaurantList)
        }, onError: {error in
            debug(error)
        }, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    
    }
    func deleteRestaurant(restaurant:Restaurant,onSuccess:@escaping ()->Void,onError:@escaping ()->Void, onNetworkError:@escaping ()->Void){
        self.restaurantDao.deleteOne(restaurant)
            .subscribe(onSuccess: {
                onSuccess()
            }, onFailure: {error in
                debug(error)
                onError()
            }, onDisposed: {
                
            })
    }
    func verifyQrCode(code:String,onSuccess:@escaping ()->Void,onError:@escaping ()->Void, onNetworkError:@escaping ()->Void){
        var request = VerifyQRCodeRequest()
        request.qrCode = code
        request.deviceId = deviceId()
        homeService.verifyQrCode(request: request)?.subscribe(onNext: {result in
            if result.result ?? false {
                self.token = result.data?.token
                self.posName = result.data?.posName
                self.posId = result.data?.posId
                self.isActive = result.data?.isActive
                onSuccess()
            } else {
                onError()
            }
        }, onError: {error in
            onNetworkError()
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    func verifyToken(token:String,onSuccess:@escaping ()->Void,onError:@escaping ()->Void, onNetworkError:@escaping ()->Void){
        appCofig.appToken = token
        homeService.verifyToken()?.subscribe(onNext: {result in
            if result.result ?? false {
                if result.data?.token != nil {
                    self.appDelegate.currentRestaurant?.token = result.data?.token
                }
                onSuccess()
            } else {
                onError()
            }
        }, onError: {error in
            onNetworkError()
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    func updateRestaurantName(name:String,onSuccess:@escaping ()->Void,onError:@escaping ()->Void, onNetworkError:@escaping ()->Void){
        appDelegate.currentRestaurant?.name = name
        restaurantDao.inserOne(appDelegate.currentRestaurant!).subscribe(onSuccess: {
            debug("update restaurant success")
            onSuccess()
        }, onFailure: {error in
            debug(error)
            debug("update restaurant failure")
            onError()
        }, onDisposed: nil).disposed(by: disposeBag)
    }
    func updateRestaurant(onSuccess:@escaping ()->Void,onError:@escaping ()->Void, onNetworkError:@escaping ()->Void){
        restaurantDao.inserOne(appDelegate.currentRestaurant!).subscribe(onSuccess: {
            debug("update restaurant success")
            onSuccess()
        }, onFailure: {error in
            debug(error)
            debug("update restaurant failure")
            onError()
        }, onDisposed: nil).disposed(by: disposeBag)
    }
}
protocol RestaurantProtocol {
    func newRestaurantLists(l : [Restaurant])
}
