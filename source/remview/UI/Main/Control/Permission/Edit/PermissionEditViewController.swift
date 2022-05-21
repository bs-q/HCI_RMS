//
//  PermissionViewController.swift
//  remview
//
//  Created by Bui Si Quan on 28/04/2022.
//

import Foundation
import UIKit

class PermissionEditViewController : BaseViewController {
    
    @IBOutlet weak var headerTitle : UILabel!
    @IBOutlet weak var name : TextFieldWithPadding!
    @IBOutlet weak var password : TextFieldWithPadding!
    @IBOutlet weak var nfc : TextFieldWithPadding!
    @IBOutlet weak var nameTitle : UILabel!
    @IBOutlet weak var passwordTitle : UILabel!
    @IBOutlet weak var nfcTitle : UILabel!
    @IBOutlet weak var permissiontitle : UILabel!
    @IBOutlet weak var saveBtn : UIButton!

    @IBOutlet weak var ibutton : UIImageView!

    var item : Permission!
    var permissionEditTableViewController:PermissionEditTableViewController!
    
    override func setup() {
        super.setup()
        registerDismissKeyboardOnTapOutSide()
        bindingData()
    }
    func bindingData(){
        name.text = item.name
//        password.text = item.password
        nfc.text = item.nfc
        checkIbutton()
    }
    func checkIbutton(){
        if item.ibutton == nil || item.ibutton!.isEmpty {
            ibutton.isUserInteractionEnabled = false
            ibutton.tintColor = .gray
        } else {
            ibutton.isUserInteractionEnabled = true
            ibutton.tintColor = .white
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PermissionEditTableViewController" {
            if let vc = segue.destination as? PermissionEditTableViewController {
                self.permissionEditTableViewController = vc
                self.permissionEditTableViewController.createPermission(range: item.role!)
                self.permissionEditTableViewController.createPermissionList()
                self.permissionEditTableViewController.getLanguageWithKey = self.getLanguageWithKey(key:)
            }
        }
    }
    override func reloadData() {
        headerTitle.text = getLanguageWithKey(key: "editpermission")
        nameTitle.text = getLanguageWithKey(key: "name")
        passwordTitle.text = getLanguageWithKey(key: "password")
        nfcTitle.text = getLanguageWithKey(key: "nfc")
        permissiontitle.text = getLanguageWithKey(key: "permission")
        saveBtn.setTitle(getLanguageWithKey(key: "save"), for: .normal)
    }
    
    @IBAction func back(_ sender : Any){
        let vc = self.getPermissionVc()
        self.dismiss(animated: true, completion:{
            vc?.employeePermission()
        })
        
    }
    @IBAction func ibutton(_ sender : Any){
        item.ibutton = ""
        checkIbutton()
    }
    @IBAction func save(_ sender : Any){
        updatePermission()
    }
    func clickCallback( permission : Permission) {
        debug(permission)
    }
    
    func updatePermission(){
        self.startIndicator(msg: getLanguageWithKey(key: "loading_msg"))
        let request = UpdatePermissionRequest()
        request.oldName = item.name
        request.employee = item
        if name.text == nil || name.text!.isEmpty {
            request.employee?.name = request.oldName
        } else {
            request.employee?.name = name.text
        }
        if password.text != nil && !password.text!.isEmpty {
            request.employee?.password = password.text
        }
        if nfc.text != nil && !nfc.text!.isEmpty {
            request.employee?.nfc = nfc.text
        }
        request.employee?.role = updateRole()
        getPermissionVc()?.updateEmployee(request: request)
    }
    func updateRole()->Int{
        return self.permissionEditTableViewController.permissionToggleItemList.filter{
            $0.check
        }.reduce(0, {$0+$1.base!})
    }
   
    func getPermissionVc()->PermissionViewController?{
        return (presentingViewController as? PermissionViewController)
    }
}
