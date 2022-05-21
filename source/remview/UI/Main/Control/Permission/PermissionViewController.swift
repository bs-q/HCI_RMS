//
//  PermissionViewController.swift
//  remview
//
//  Created by Bui Si Quan on 28/04/2022.
//

import Foundation
import UIKit

class PermissionViewController : BaseViewController,SocketListener {
    
    var MAIN_SCREEN = "PERMISSION_SCREEN"
    var queue : Queue<Message> = Queue()

    
    func onMessage(socketEventModel: SocketEventModel?) {
        debugPrint("* \(socketEventModel?.toJSON())")
        if socketEventModel?.event == .message {
            if socketEventModel?.message?.responseCode == 200 {
                if socketEventModel?.message?.screen != nil && socketEventModel?.message?.screen != MAIN_SCREEN{
                    return
                }
                switch socketEventModel?.message?.cmd {
                case Command.LAY_DANH_SACH_NHANVIEN_UPDATE:
                    if socketEventModel?.message?.data != nil {
                        updateTableView(data: (socketEventModel?.message?.data)! as! String)
                    }
                    self.stopIndicator()
                    
                    break
                case Command.COMMAND_TOKEN_CLIENT: // check for websocket reconnect, if app open from background, this case will be run first
                    debug("token client")
                    break
                case Command.UPDATE_NHAN_VIEN:
                    getPermissionEditVc()?.stopIndicator()
                    presentedViewController?.dismiss(animated: true, completion: {
                        self.employeePermission()
                    })
                    
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
        self.stopIndicator()
        (self.presentedViewController as? BaseViewController)?.stopIndicator()
    }
    
    func onError() {
        self.stopIndicator()
        (self.presentedViewController as? BaseViewController)?.stopIndicator()
    }
    
    func onConnected() {
        debugPrint("* socket connected")
        let msg = queue.dequeue()
        if msg != nil {
            WebsocketConnection.getInstance().sendEvent(messsage: msg!)
        }
    }
    
    @IBOutlet weak var headerTitle : UILabel!
    var items : [Permission] = []
    var permissionTableViewController:PermissionTableViewController!
    var socketConnection : WebsocketConnection!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PermissionTableViewController" {
            if let vc = segue.destination as? PermissionTableViewController {
                self.permissionTableViewController = vc
                self.permissionTableViewController.items = self.items
                self.permissionTableViewController.clickCallback = clickCallback(permission:)
            }
        }
    }
    override func reloadData() {
        headerTitle.text = getLanguageWithKey(key: "permission")
    }
    
    @IBAction func back(_ sender : Any){
        dismiss(animated: true, completion: nil)
        getMainVc()?.lockActiveNotification = false
    }
    func clickCallback( permission : Permission) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "permission", bundle:  nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PermissionEditViewController") as! PermissionEditViewController
        vc.item = permission
        vc.modalPresentationStyle = .fullScreen
        let mainVc = getMainVc()
        mainVc?.removeMainActiveObserver()
        WebsocketConnection.getInstance().socketListener = self
        self.present(vc, animated: true)
    }
    func getMainVc()->MainViewController?{
        return (presentingViewController as? MainViewController)
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
        self.stopIndicator()
        getPermissionEditVc()?.stopIndicator()
    }
    @objc private func applicationDidBecomeActive() {
        debug("* foreground")
        socketConnection.startSocket()
        socketConnection.socketListener = self
    }
    
    func updateEmployee(request:UpdatePermissionRequest){
        let msg = Message()
        msg.screen = MAIN_SCREEN
        msg.cmd = Command.UPDATE_NHAN_VIEN
        msg.token = appDelegate.currentRestaurant?.token
        msg.requestData = request
        debug(request.toJSON())
        if !WebsocketConnection.getInstance().sendEvent(messsage: msg) {
            queue.enqueue(msg)
        }
        
    }
    func employeePermission(){
        self.startIndicator(msg: getLanguageWithKey(key: "loading_msg"))
        let msg = Message()
        msg.screen = MAIN_SCREEN
        msg.cmd = Command.LAY_DANH_SACH_NHANVIEN_UPDATE
        msg.token = appDelegate.currentRestaurant?.token
        if !WebsocketConnection.getInstance().sendEvent(messsage: msg) {
            queue.enqueue(msg)
        }
        
    }
   
    func updateTableView(data:String){
        self.permissionTableViewController.items = PermissionResponse(JSONString: data, context: nil)!.datas!
        self.permissionTableViewController.tableView.reloadData()
    }
    func getPermissionEditVc()->PermissionEditViewController?{
        return (presentedViewController as? PermissionEditViewController)
    }
}
