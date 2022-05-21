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
import Fastis
class SettingViewController: BaseViewController,TabbarProtocol{
    var settingCollectionViewController: SettingCollectionViewController!
    @IBOutlet weak var headerTitle : UILabel!
    var from = ""
    var to = ""
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SettingCollectionViewController" {
            if let vc = segue.destination as? SettingCollectionViewController {
                self.settingCollectionViewController = vc
                self.settingCollectionViewController.callback = settingCallback(item:)
            }
        }
    }
    override func reloadData() {
        headerTitle.text = getLanguageWithKey(key: "control")
    }
    func settingCallback(item:SettingItemType){
        switch item.type{
        case .printInvoice:
            openCalendar()
        case .employeeBilling:
            self.myRootVc(vc: self)?.employeeMoney()
        case .turnOnTeamView:
            self.myRootVc(vc: self)?.employeePermission()
        case .turnOnTunnel:
            break
//            self.myRootVc(vc: self)?.openTunnel()
        }
    }
   
    func getEmployeeDetailViewController()->EmployeeDetailViewController?{
        return (self.presentedViewController?.presentedViewController as? EmployeeDetailViewController)
    }
    override func viewDidAppear(_ animated: Bool) {
        debug("current screen")
        myRootVc(vc: self)?.currentScreen = self
    }
    func openCalendar() {
        let fastisController = FastisController(mode: .range)
        fastisController.title = "Choose range"
        fastisController.initialValue = .none
        fastisController.minimumDate = Calendar.current.date(byAdding: .month, value: -3, to: Date())
        fastisController.maximumDate = Date()
        fastisController.allowToChooseNilDate = true
        fastisController.doneHandler = { newValue in
            if let rangeValue = newValue {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                self.from = formatter.string(from: rangeValue.fromDate)
                self.to = formatter.string(from: rangeValue.toDate)
                fastisController.dismissHandler = {
                    self.myRootVc(vc: self)?.ỉnReport()
                }
            }
        }
        
    
        fastisController.present(above: self)
    }
}
