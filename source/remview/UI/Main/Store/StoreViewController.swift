//
//  HomeViewController.swift
//  agilemark
//
//  Created by _ on 15/12/2021.
//

import Foundation
import Resolver
import RxSwift
import ObjectMapper
import MKRingProgressView
import UIKit
import AVFoundation
import QRCodeReader
class StoreViewController: BaseViewController, ScanQRCodeDelegate,TabbarProtocol,RestaurantProtocol,UIPopoverPresentationControllerDelegate{
    @IBOutlet weak var headerView : UIView!
    @IBOutlet weak var headerTitle : UILabel!
    @IBOutlet weak var allRestaurant : UILabel!
    @IBOutlet weak var langBtn : UIImageView!

    
    var storeTableViewController : StoreTableViewController?
    func newRestaurantLists(l: [Restaurant]) {
        self.storeTableViewController?.restaurantList = viewmodel.restaurantList
        self.storeTableViewController?.tableView.reloadData()
    }
    
    var viewmodel = StoreViewModel()
    
    override func setup() {
        super.setup()
        viewmodel.restaurantCallback = self
    }
    override func reloadData(){
        headerTitle.text = getLanguageWithKey(key: "listofrestaurant")
        allRestaurant.text = getLanguageWithKey(key: "allrestaurants")
        changeFlag()
    }
    func changeFlag(){
        //vn,eng,ger
        if appDelegate.languageKey == "vi" {
            langBtn.image = UIImage(named: "vn")
        }
        if appDelegate.languageKey == "en" {
            langBtn.image = UIImage(named: "eng")
        }
        if appDelegate.languageKey == "de" {
            langBtn.image = UIImage(named: "ger")
        }
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StoreTableViewController" {
            if let vc = segue.destination as? StoreTableViewController {
                self.storeTableViewController = vc
                self.storeTableViewController?.restaurantList = viewmodel.restaurantList
                self.storeTableViewController?.deleteRestaurantCallback = deleteRestaurantCallback(restaurant:)
                self.storeTableViewController?.selectRestaurantCallback = selectRestaurantCallback(restaurant:)
                self.storeTableViewController?.getLanguageWithKey = self.getLanguageWithKey(key:)
            }
        }
        if segue.identifier == "LanguageViewController" {
            if let tvc = segue.destination as? LanguageViewController
            {
                tvc.popoverPresentationController?.delegate = self
                tvc.popoverPresentationController?.permittedArrowDirections = .init(rawValue: 0)
                if let ppc = tvc.popoverPresentationController
                {
                    // 198;116
                    ppc.sourceView = self.view
                    ppc.sourceRect = CGRect(x: headerView.frame.maxX-198, y: headerView.frame.maxY + 10, width: 198, height: 116)
                    ppc.popoverLayoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
                    ppc.delegate = self
                }
            }
        }
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    func selectRestaurantCallback(restaurant:Restaurant){
        debug(restaurant)
        appDelegate.currentRestaurant = restaurant
        self.verifyToken()
    }
    func deleteRestaurantCallback(restaurant:Restaurant){
        self.alertDialog(title: nil, msg: self.getLanguageWithKey(key: "restaurant_delete"), yes: {
            self.viewmodel.deleteRestaurant(restaurant: restaurant, onSuccess: {
                self.makeToast(title: nil, msg: "Delete restaurant success")
            }, onError: {
                
            }, onNetworkError: {
                
            })
        }, no: {
            
        })
    }
    func callbackQRCodeValue(code: String, type: ScanQrcodeType) {
        self.presentedViewController?.dismiss(animated: true, completion: {
            self.handleQrcode(result: code)
            
        })
    }
    func handleQrcode(result:String){
        appDelegate.currentRestaurant = Restaurant()
        appDelegate.currentRestaurant?.lastAccessDate = Date()
        appDelegate.currentRestaurant?.name = ""
        appDelegate.currentRestaurant?.id = Date().currentTimeMillis().description
        verifyQrCode(result: result)
    }
    
    func verifyQrCode(result:String){
        self.startIndicator(msg: getLanguageWithKey(key: GlobalizedString.loadingMsg))
        viewmodel.verifyQrCode(code: result, onSuccess: {
            // update restaurant token
            self.stopIndicator()
            self.showUpdateRestaurantNameDialog()
        }, onError: {
            self.appDelegate.currentRestaurant = nil
            self.handleRequestError(msg: self.getLanguageWithKey(key: "qr_error"))
        }, onNetworkError: {
            self.appDelegate.currentRestaurant = nil
            self.handleNetworkError()
        })
    }
    func showUpdateRestaurantNameDialog(){
        self.appDelegate.currentRestaurant?.token = self.viewmodel.token!
        self.appDelegate.currentRestaurant?.name = self.viewmodel.posName!
        self.appDelegate.currentRestaurant?.posId = self.viewmodel.posId!
        self.appDelegate.currentRestaurant?.active = self.viewmodel.isActive
        
        if checkPosId() {
            self.viewmodel.updateRestaurant(onSuccess: {
                self.appDelegate.currentRestaurant = nil
            }, onError: {}, onNetworkError: {})
            return
        }
        
        showUpdateNameDialog()
        
    }
    func checkPosId()->Bool{
        return viewmodel.restaurantList.contains {
            return $0.posId == self.viewmodel.posId
        }
    }
    func showUpdateNameDialog(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "store", bundle:  nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "EditNameViewController") as! EditNameViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.restaurantName = viewmodel.posName
        vc.callback = self.updateRestaurantName(name:)
        vc.cancelCallback = self.updateNameCancel
        self.present(vc, animated: true)
    }
    func updateNameCancel(){
        self.viewmodel.updateRestaurant(onSuccess: {
            self.appDelegate.currentRestaurant = nil
        }, onError: {}, onNetworkError: {})
    }
    
    func updateRestaurantName(name:String){
        (self.presentedViewController as! EditNameViewController).startIndicator(msg: "Updating, please wait...")
        viewmodel.updateRestaurantName(name: name, onSuccess: {
            (self.presentedViewController as! EditNameViewController).stopIndicator()
            self.presentedViewController?.dismiss(animated: true, completion: {
                self.showCheckDialog()
            })
        }, onError: {
            self.presentedViewController?.dismiss(animated: true, completion: nil)
            debug("??")
        }, onNetworkError: {})
    }
    func updateRestaurant(){
        viewmodel.updateRestaurant(onSuccess: {}, onError: {}, onNetworkError: {})
    }
    func showCheckDialog(){
        if appDelegate.currentRestaurant?.active ?? false {
            self.appDelegate.currentRestaurant = nil
            return
            
        }
        showActiveDialog()
    }
    func showActiveDialog(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "store", bundle:  nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "StoreActiveViewController") as! StoreActiveViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.callback = self.checkActiveCallback
        self.present(vc, animated: true)
    }
    func checkActiveCallback(){
        self.presentedViewController?.dismiss(animated: true, completion: {
            self.verifyToken()
        })
    }
    
    func verifyToken(){
        self.startIndicator(msg: self.getLanguageWithKey(key: "loading_msg"))
        appDelegate.currentRestaurant?.active = false
        viewmodel.verifyToken(token: (appDelegate.currentRestaurant?.token)!, onSuccess: {
            self.verifySocketToken()
        }, onError: {
            self.stopIndicator()
//            self.handleRequestError()
            self.showActiveDialog()
        }, onNetworkError: {
            self.stopIndicator()
            self.handleNetworkError()
        })
    }
    
    func verifySocketToken(){
        myRootVc(vc: self)?.verifyTokenSocket()
    }
    
    @IBAction func scanAction(_ sender: AnyObject) {
        
        let scanQrcodeVC = ScanQrCodeVCViewController.loadFromNib()
        scanQrcodeVC.delegate = self;
        scanQrcodeVC.typeScan = .verifyMobile
        scanQrcodeVC.modalPresentationStyle = .fullScreen
        self.present(scanQrcodeVC, animated: false, completion: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        debug("current screen")
        myRootVc(vc: self)?.currentScreen = self
    }
    
}

