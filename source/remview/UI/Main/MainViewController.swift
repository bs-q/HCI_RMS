//
//  MainViewController.swift
//  agilemark
//
//  Created by _ on 16/12/2021.
//

import Foundation
import UIKit
import Resolver
import RxSwift
import ObjectMapper

class MainViewController: UITabBarController,UITabBarControllerDelegate,SocketListener {
    
    @Injected
    var appCofig: AppConfiguration
    
    @Injected
    var appDelegate : AppDelegate
    
    var storeVc : StoreViewController!
    var revenueVc : RevenueViewController!
    var settingVc : SettingViewController!
    var newsVc : NewsViewController!
    var currentScreen : BaseViewController! {
        didSet {
            debug(String.init(describing: currentScreen.classForCoder))
        }
    }
    
    var MAIN_SCREEN = "MAIN_SCREEN"
    var currentCMD : String?
    
    var queue : Queue<Message> = Queue()
    /// Language
    func getLanguageWithKey(key: String) -> String {
        return key.localized(bundle: appCofig.languageBundle)
    }
    func makeToast(title:String?, msg: String, myAction: @escaping ()->() = { })
    {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: getLanguageWithKey(key: "confirm_ok"), style: .default, handler: {_ in myAction()
        }))
        self.present(alert, animated: true)
        
    }
    @IBOutlet var mTabBar: UITabBar!
    var socketConnection : WebsocketConnection!
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let vc = viewController as? RevenueViewController, appDelegate.currentRestaurant == nil {
            self.makeToast(title: nil, msg: self.getLanguageWithKey(key: "restaurant_msg"))
            return false
        }
        if let vc = viewController as? SettingViewController, appDelegate.currentRestaurant == nil {
            self.makeToast(title: nil, msg: self.getLanguageWithKey(key: "restaurant_msg"))
            return false
        }
        return true
    }
    
    func verifyTokenSocket(){
        let msg = Message()
        msg.screen = MAIN_SCREEN
        msg.cmd = Command.COMMAND_TOKEN_CLIENT
        currentCMD = Command.COMMAND_TOKEN_CLIENT
        msg.token = appDelegate.currentRestaurant?.token
        if !WebsocketConnection.getInstance().sendEvent(messsage: msg) {
            queue.enqueue(msg)
        }
        
    }
    func getSetting(){
        let msg = Message()
        msg.screen = MAIN_SCREEN
        msg.cmd = Command.COMMAND_GET_SETTING
        currentCMD = Command.COMMAND_GET_SETTING
        msg.token = appDelegate.currentRestaurant?.token
        if !WebsocketConnection.getInstance().sendEvent(messsage: msg) {
            queue.enqueue(msg)
        }
        
    }
    func employeeMoney(){
        settingVc.startIndicator(msg: getLanguageWithKey(key: "loading_msg"))
        let msg = Message()
        msg.screen = MAIN_SCREEN
        msg.cmd = Command.LAY_DANH_SACH_NHAN_VIEN
        currentCMD = Command.LAY_DANH_SACH_NHAN_VIEN
        msg.token = appDelegate.currentRestaurant?.token
        if !WebsocketConnection.getInstance().sendEvent(messsage: msg) {
            queue.enqueue(msg)
        }
        
    }
   
    func openTunnel(){
        settingVc.startIndicator(msg: getLanguageWithKey(key: "loading_msg"))
        let msg = Message()
        msg.screen = MAIN_SCREEN
        msg.cmd = Command.BAT_TUNNEL
        currentCMD = Command.BAT_TUNNEL
        msg.token = appDelegate.currentRestaurant?.token
        if !WebsocketConnection.getInstance().sendEvent(messsage: msg) {
            queue.enqueue(msg)
        }
        
    }
    func openTeamview(){
        settingVc.startIndicator(msg: getLanguageWithKey(key: "loading_msg"))
        let msg = Message()
        msg.screen = MAIN_SCREEN
        msg.cmd = Command.BAT_TEAM_VIEW
        currentCMD = Command.BAT_TEAM_VIEW
        msg.token = appDelegate.currentRestaurant?.token
        if !WebsocketConnection.getInstance().sendEvent(messsage: msg) {
            queue.enqueue(msg)
        }
        
    }
    func employeePermission(){
        settingVc.startIndicator(msg: getLanguageWithKey(key: "loading_msg"))
        let msg = Message()
        msg.screen = MAIN_SCREEN
        msg.cmd = Command.LAY_DANH_SACH_NHANVIEN_UPDATE
        currentCMD = Command.LAY_DANH_SACH_NHANVIEN_UPDATE
        msg.token = appDelegate.currentRestaurant?.token
        if !WebsocketConnection.getInstance().sendEvent(messsage: msg) {
            queue.enqueue(msg)
        }
        
    }
    func ỉnReport(){
        settingVc.startIndicator(msg: getLanguageWithKey(key: "loading_msg"))
        let msg = Message()
        msg.screen = MAIN_SCREEN
        msg.cmd = Command.IN_REPORT_Z
        currentCMD = Command.IN_REPORT_Z
        let request = SocketReportRequest(JSON: ["fromDate":settingVc.from,"pos":appDelegate.currentRestaurant?.getSetting().fromPcs,"toDate":settingVc.to], context: nil)!
        msg.requestData = request
        msg.token = appDelegate.currentRestaurant?.token
        if !WebsocketConnection.getInstance().sendEvent(messsage: msg) {
            queue.enqueue(msg)
        }
        
    }
    func getRevenue(){
        revenueVc.startIndicator(msg: getLanguageWithKey(key: "loading_msg"))
        let msg = Message()
        msg.screen = MAIN_SCREEN
        msg.cmd = Command.COMMAND_REPORT_REVENUE
        currentCMD = Command.COMMAND_REPORT_REVENUE
        msg.token = appDelegate.currentRestaurant?.token
        let socketRevenueRequest = SocketRevenueRequest(JSON: ["kind":SocketRevenueRequest.REPORT_KIND_REVENUE_DAY], context: nil)!
        msg.requestData = socketRevenueRequest
        if !WebsocketConnection.getInstance().sendEvent(messsage: msg) {
            queue.enqueue(msg)
        }
        
    }
    func checkEmployee(name:String){
        settingVc.getEmployeeDetailViewController()?.startIndicator(msg: getLanguageWithKey(key: "loading_msg"))
        let msg = Message()
        msg.screen = MAIN_SCREEN
        msg.cmd = Command.TINH_TIEN_NHAN_VIEN
        currentCMD = Command.TINH_TIEN_NHAN_VIEN
        msg.token = appDelegate.currentRestaurant?.token
        // pos : String
        let request = EmployeeRequest(JSON: ["employee":name,"pos":appDelegate.currentRestaurant?.getSetting().fromPcs], context: nil)!
        msg.requestData = request
        if !WebsocketConnection.getInstance().sendEvent(messsage: msg) {
            queue.enqueue(msg)
        }
        
    }
    func printEmployee(name:String){
        settingVc.getEmployeeDetailViewController()?.startIndicator(msg: getLanguageWithKey(key: "loading_msg"))
        let msg = Message()
        msg.screen = MAIN_SCREEN
        msg.cmd = Command.IN_DOANH_THU_NHAN_VIEN
        currentCMD = Command.IN_DOANH_THU_NHAN_VIEN
        msg.token = appDelegate.currentRestaurant?.token
        let request = EmployeeRequest(JSON: ["employee":name,"pos":appDelegate.currentRestaurant?.getSetting().fromPcs], context: nil)!
        msg.requestData = request
        if !WebsocketConnection.getInstance().sendEvent(messsage: msg) {
            queue.enqueue(msg)
        }
        
    }
    func getListBillOfDay(){
        revenueVc.startIndicator(msg: getLanguageWithKey(key: "loading_msg"))
        let msg = Message()
        msg.screen = MAIN_SCREEN
        msg.cmd = Command.COMMAND_GET_BILL
        currentCMD = Command.COMMAND_GET_BILL
        msg.token = appDelegate.currentRestaurant?.token
        let request = SocketBillRequest(JSON: ["date":appDelegate.startDate.convertDateToString(format: "yyyy-MM-dd"),"fromPc":appDelegate.currentRestaurant!.getSetting().fromPcs!], context: nil)!
        msg.requestData = request
        debug(request.toJSONString())
        if !WebsocketConnection.getInstance().sendEvent(messsage: msg) {
            queue.enqueue(msg)
        }
        
    }
    func getLogFood(){
        revenueVc.startIndicator(msg: getLanguageWithKey(key: "loading_msg"))
        let msg = Message()
        msg.screen = MAIN_SCREEN
        msg.cmd = Command.COMMAND_GET_LOG_FOOD
        currentCMD = Command.COMMAND_GET_LOG_FOOD
        msg.token = appDelegate.currentRestaurant?.token
        let request = SocketBillRequest(JSON: ["date":appDelegate.startDate.convertDateToString(format: "yyyy-MM-dd"),"fromPc":appDelegate.currentRestaurant!.getSetting().fromPcs!], context: nil)!
        msg.requestData = request
        debug(request.toJSONString())
        if !WebsocketConnection.getInstance().sendEvent(messsage: msg) {
            queue.enqueue(msg)
        }
    }
    
    func navigateToRevenueDetail(data:String){
        error("remove main observer")
        let storyBoard: UIStoryboard = UIStoryboard(name: "revenue", bundle:  nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "RevenueDetailViewController") as! RevenueDetailViewController
        vc.modalPresentationStyle = .fullScreen
        vc.viewmodel.item = SocketRevenueResponse(JSONString: data, context: nil)
        WebsocketConnection.getInstance().socketListener = vc
        self.removeMainActiveObserver()
        self.revenueVc.present(vc, animated: true)
    }
    func navigateToSell(data:String){
        let storyBoard: UIStoryboard = UIStoryboard(name: "sell", bundle:  nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SellViewController") as! SellViewController
        vc.viewmodel.item = SocketBillResponse(JSONString: data, context: nil)!.datas!
        vc.modalPresentationStyle = .fullScreen
        self.revenueVc.present(vc, animated: true)
    }
    func navigateToOrder(data:String){
        let storyBoard: UIStoryboard = UIStoryboard(name: "order", bundle:  nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "OrderViewController") as! OrderViewController
        vc.items = SocketLogFoodResponse(JSONString: data, context: nil)!.datas!
        vc.modalPresentationStyle = .fullScreen
        self.revenueVc.present(vc, animated: true)
    }
    func navigateToEmployee(data:String){
        let storyBoard: UIStoryboard = UIStoryboard(name: "control", bundle:  nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "EmployeeViewController") as! EmployeeViewController
        vc.items = EmployeeResponse(JSONString: data, context: nil)!.employees!
        vc.modalPresentationStyle = .fullScreen
        self.settingVc.present(vc, animated: true)
    }
    func navigateToPermission(data:String){
        let storyBoard: UIStoryboard = UIStoryboard(name: "permission", bundle:  nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PermissionViewController") as! PermissionViewController
        vc.items = PermissionResponse(JSONString: data, context: nil)!.datas!
        vc.modalPresentationStyle = .fullScreen
        WebsocketConnection.getInstance().socketListener = vc
        self.removeMainActiveObserver()
        self.settingVc.present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        self.delegate = self
        storeVc = viewControllers![0] as? StoreViewController
        revenueVc = viewControllers![1] as? RevenueViewController
        settingVc = viewControllers![2] as? SettingViewController
        newsVc = viewControllers![3] as? NewsViewController
        socketConnection = WebsocketConnection.getInstance()
        socketConnection.socketListener = self
        reloadLanguage()
    }
    func reloadLanguage(){
        tabBar.items?[0].title = getLanguageWithKey(key: "store")
        tabBar.items?[1].title = getLanguageWithKey(key: "revenue")
        tabBar.items?[2].title = getLanguageWithKey(key: "control")
        tabBar.items?[3].title = getLanguageWithKey(key: "news")
    }

  
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    var lockActiveNotification = false
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        debug("main appear")
        if !lockActiveNotification {
            socketConnection.socketListener = self
            NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
            lockActiveNotification = true
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        debug("main disappear")
//        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
//
//        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    func removeMainActiveObserver(){
        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc private func applicationWillResignActive() {
        debug("* background")
        socketConnection.stopSocket()
        socketConnection.socketListener = nil
        currentScreen.stopIndicator()
//        socketConnection.lastMessage = nil 
    }
    
    @objc private func applicationDidBecomeActive() {
        debug("* foreground")
        socketConnection.startSocket()
        socketConnection.socketListener = self
    }
    
    
    func onMessage(socketEventModel: SocketEventModel?) {
        if socketEventModel?.event == .message {
            if socketEventModel?.message?.responseCode == 200 {
                if socketEventModel?.message?.screen != MAIN_SCREEN{
                    return
                }
                switch socketEventModel?.message?.cmd {
                case Command.COMMAND_VERIFY_QRCODE:
                    break
                case Command.COMMAND_TOKEN_CLIENT:
                    WebsocketConnection.getInstance().session = appDelegate.currentRestaurant?.token
                    self.getSetting()
                    break
                case Command.COMMAND_GET_SETTING:
                    appDelegate.currentRestaurant?.active = true
                    // TODO: navigate to revenue
                    appDelegate.currentRestaurant?.setting = socketEventModel?.message?.data as! String
                    storeVc.updateRestaurant()
                    storeVc.stopIndicator()
                    selectedIndex = 1
                    break
                case Command.COMMAND_REPORT_REVENUE:
                    revenueVc.stopIndicator()
                    if socketEventModel?.message?.data != nil {
                        navigateToRevenueDetail(data: (socketEventModel?.message?.data)! as! String)
                    }
                    break
                case Command.COMMAND_GET_BILL:
                    revenueVc.stopIndicator()
                    if socketEventModel?.message?.data != nil {
                        navigateToSell(data: (socketEventModel?.message?.data)! as! String)
                    }
                    break
                case Command.COMMAND_GET_LOG_FOOD:
                    revenueVc.stopIndicator()
                    if socketEventModel?.message?.data != nil {
                        navigateToOrder(data: (socketEventModel?.message?.data)! as! String)
                    }
                    break
                case Command.IN_REPORT_Z,Command.BAT_TEAM_VIEW,Command.BAT_TUNNEL:
                    settingVc.stopIndicator()
                    break
                case Command.LAY_DANH_SACH_NHAN_VIEN:
                    settingVc.stopIndicator()
                    if socketEventModel?.message?.data != nil {
                        navigateToEmployee(data: (socketEventModel?.message?.data)! as! String)
                    }
                    break
                case Command.IN_DOANH_THU_NHAN_VIEN,Command.TINH_TIEN_NHAN_VIEN:
                    settingVc.getEmployeeDetailViewController()?.stopIndicator()
                    break
                case Command.LAY_DANH_SACH_NHANVIEN_UPDATE:
                    settingVc.stopIndicator()
                    if socketEventModel?.message?.data != nil {
                        navigateToPermission(data: (socketEventModel?.message?.data)! as! String)
                    }
                    break
                default:
                        break
                }
            } else {
                
            }
        } else if socketEventModel?.event == .offline || socketEventModel?.event == .error {
            // notify socket error
            debug(socketEventModel?.event)
            storeVc.stopIndicator()
            revenueVc.stopIndicator()
        }
    }
    
    func onTimeout(message: Message?) {
        switch message?.cmd {
        case Command.COMMAND_REPORT_REVENUE,Command.COMMAND_GET_SETTING:
            storeVc.stopIndicator()
            break
        case Command.COMMAND_REPORT_REVENUE,Command.COMMAND_GET_BILL,Command.COMMAND_GET_LOG_FOOD:
            revenueVc.stopIndicator()
            break
        case Command.IN_REPORT_Z,Command.BAT_TEAM_VIEW,Command.BAT_TUNNEL,Command.LAY_DANH_SACH_NHAN_VIEN:
            settingVc.stopIndicator()
            break
        case Command.IN_DOANH_THU_NHAN_VIEN,Command.TINH_TIEN_NHAN_VIEN:
            settingVc.getEmployeeDetailViewController()?.stopIndicator()
        default:
            break
        }
        currentScreen?.stopIndicator()
        debug(String.init(describing: currentScreen.classForCoder))
    }
    
    func onError() {
        debugPrint("* socket error")
    }
    
    func onConnected() {
        debugPrint("* socket connected")
        let msg = queue.dequeue()
        if msg != nil {
            WebsocketConnection.getInstance().sendEvent(messsage: msg!)
        }
    }
}

