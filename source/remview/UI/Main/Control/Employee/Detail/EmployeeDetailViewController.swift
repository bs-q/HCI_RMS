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
class EmployeeDetailViewController: BaseViewController,TabbarProtocol{
    var employeeDetailCollectionViewController: EmployeeDetailCollectionViewController!
    var items : [Money] = []
    var employee : EmployeeObject!
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var totalMoney: UILabel!

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmployeeDetailCollectionViewController" {
            if let vc = segue.destination as? EmployeeDetailCollectionViewController {
                self.employeeDetailCollectionViewController = vc
                self.employeeDetailCollectionViewController.items = self.items
            }
        }
    }
    override func reloadData() {
        totalMoney.text = getLanguageWithKey(key: "TOTALMONEY")
    }
    
    override func setup() {
        super.setup()
        employeeName.text = employee.employeeName
        total.text =  (employee.money!.reduce(0, {$0+Double($1.money!)})/100).toRestaurantMoney(setting: appDelegate.currentRestaurant!.getSetting())
    }
    
    @IBAction func back(_ sender : Any){
        dismiss(animated: true, completion: nil)
    }
    @IBAction func print(_ sender : Any){
        getMainViewController()?.printEmployee(name: employee.employeeName!)
    }
    @IBAction func check(_ sender : Any){
        getMainViewController()?.checkEmployee(name: employee.employeeName!)
    }
    func getMainViewController()->MainViewController? {
        return (self.presentingViewController?.presentingViewController as? MainViewController)
    }
}
