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
class RevenueViewController: BaseViewController,TabbarProtocol{
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var selectedDate : UILabel!
    @IBOutlet weak var revenue : UILabel!
    @IBOutlet weak var currentRevenue : UILabel!
    

    var revenueCollectionViewController: RevenueCollectionViewController!
    override func viewDidAppear(_ animated: Bool) {
        restaurantName.text = appDelegate.currentRestaurant?.name
        debug("current screen")
        myRootVc(vc: self)?.currentScreen = self
    }
    override func reloadData() {
        revenue.text = getLanguageWithKey(key: "revenue")
        currentRevenue.text = getLanguageWithKey(key: "currentrevenue")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RevenueCollectionViewController" {
            if let vc = segue.destination as? RevenueCollectionViewController {
                self.revenueCollectionViewController = vc
                self.revenueCollectionViewController.callback = revenueCallback(item:)
            }
        }
    }
    func revenueCallback(item:RevenueItemType){
        debug(item)
        switch item.type {
        case .revenueSell:
            self.getListBillOfDay()
            break
        case .revenueCancel:
            self.getLogFood()
            break
        case .sortRevenue:
            break
        case .sortMonth:
            break
        case .sortMember:
            break
        case .sortHouse:
            break
        case .sortMachine:
            break
        case .sortProduct:
            break
        case .sortWeek:
            break
        case .sortTime:
            break
        case .sortType:
            break
        }
    }
    @IBAction func currentRevenueClick(_ sender: Any) {
        myRootVc(vc: self)?.getRevenue()
    }
    func getListBillOfDay(){
        debug("get list bill")
        myRootVc(vc: self)?.getListBillOfDay()
    }
    
    func getLogFood(){
        debug("get log food")
        myRootVc(vc: self)?.getLogFood()
    }
    @IBAction func openCalendar(_ sender: Any) {
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
                let from = formatter.string(from: rangeValue.fromDate)
                let to = formatter.string(from: rangeValue.toDate)
                let range =  from == to ? from : (from + "-" + to)
                self.appDelegate.startDate = rangeValue.fromDate
                self.appDelegate.endDate = rangeValue.toDate
                debug(range)
                self.selectedDate.text = range
            }
        }
    
        fastisController.present(above: self)
    }
    override func setup() {
        super.setup()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let from = formatter.string(from: appDelegate.startDate)
        let to = formatter.string(from: appDelegate.endDate)
        let range =  from == to ? from : (from + "-" + to)
        self.selectedDate.text = range
    }
}
