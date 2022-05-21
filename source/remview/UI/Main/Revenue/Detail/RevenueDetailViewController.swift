//
//  ProfileViewController.swift
//  agilemark
//
//  Created by _ on 23/12/2021.
//

import Foundation
import UIKit
import Resolver
import RxSwift
import ObjectMapper
import DropDown
import CropViewController
class RevenueDetailViewController: BaseViewController,SocketListener{
    var MAIN_SCREEN = "REVENUE_SCREEN"

    func onMessage(socketEventModel: SocketEventModel?) {
        debugPrint("* \(socketEventModel?.toJSON())")
        if socketEventModel?.event == .message {
            if socketEventModel?.message?.responseCode == 200 {
                if socketEventModel?.message?.screen != nil && socketEventModel?.message?.screen != MAIN_SCREEN{
                    return
                }
                switch socketEventModel?.message?.cmd {
                case Command.COMMAND_REPORT_REVENUE:
                    if socketEventModel?.message?.data != nil {
                        viewmodel.item = SocketRevenueResponse(JSONString: (socketEventModel?.message?.data)! as! String, context: nil)
                        self.updateRevenue()
                        self.startTimer()
                    }
                    break
                case Command.COMMAND_TOKEN_CLIENT: // check for websocket reconnect, if app open from background, this case will be run first
                    self.tickDispose = CompositeDisposable() // reset disposable, when call dispopse the next displosable insert will be ignore
                    self.startTimer()
                    break
                default:
                        break
                }
            } else {
                
            }
        } else if socketEventModel?.event == .offline || socketEventModel?.event == .error {
            // notify socket error
        }
    }
    
    func onTimeout(message: Message?) {
        tickDispose.dispose()
    }
    
    func onError() {
        tickDispose.dispose()
    }
    
    func onConnected() {
    }
    
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var sales: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var revenue: UILabel!
    var viewmodel = RevenueDetailViewModel()
    var revenueDetailCollectionViewController: RevenueDetailCollectionViewController!
    var socketConnection : WebsocketConnection!

    override func viewDidAppear(_ animated: Bool) {
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RevenueDetailCollectionViewController" {
            if let vc = segue.destination as? RevenueDetailCollectionViewController {
                self.revenueDetailCollectionViewController = vc
                self.revenueDetailCollectionViewController.setting = appDelegate.currentRestaurant?.getSetting()
            }
        }
    }
    override func reloadData() {
        sales.text = getLanguageWithKey(key: "sales")
        revenue.text = getLanguageWithKey(key: "REVENUE")
    }
    override func setup() {
        super.setup()
        updateRevenue()
        socketConnection = WebsocketConnection.getInstance()
        socketConnection.socketListener = self
        startTimer()
    }
    func updateRevenue(){
        restaurantName.text = appDelegate.currentRestaurant?.name
        total.text =  viewmodel.item?.dataReport?.reduce(0, {$0+$1.totalMoney!}).toRestaurantMoney(setting: appDelegate.currentRestaurant!.getSetting())
        self.revenueDetailCollectionViewController.items = viewmodel.item?.dataReport ?? []
        self.revenueDetailCollectionViewController.collectionView.reloadData()
    }
    var tickDispose = CompositeDisposable()
    func startTimer(){
        tickDispose.insert(Observable<Int>.timer(.seconds(1), scheduler: SerialDispatchQueueScheduler(qos: .background)).observe(on: MainScheduler.instance).subscribe(onNext: {_ in
            self.getRevenue()
        }, onError: {error in}, onCompleted: nil, onDisposed: nil))
    }
    func getRevenue(){
        let msg = Message()
        msg.screen = MAIN_SCREEN
        msg.cmd = Command.COMMAND_REPORT_REVENUE
        msg.token = appDelegate.currentRestaurant?.token
        let socketRevenueRequest = SocketRevenueRequest(JSON: ["kind":SocketRevenueRequest.REPORT_KIND_REVENUE_DAY], context: nil)!
        msg.requestData = socketRevenueRequest
        WebsocketConnection.getInstance().sendEvent(messsage: msg)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    
    @objc private func applicationWillResignActive() {
        debug("* background")
        socketConnection.stopSocket()
        socketConnection.socketListener = nil
        tickDispose.dispose()
    }
    var inBackground = false
    @objc private func applicationDidBecomeActive() {
        debug("* foreground")
        socketConnection.startSocket()
        socketConnection.socketListener = self
        inBackground = true
    }
    
    @IBAction func back(_ sender: Any) {
        tickDispose.dispose()
        (presentingViewController as? MainViewController)?.lockActiveNotification = false
        warning("revenue detail back")
        self.dismiss(animated: true, completion:nil)
    }
}
