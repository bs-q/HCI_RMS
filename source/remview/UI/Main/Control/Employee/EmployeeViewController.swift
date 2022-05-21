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
class EmployeeViewController: BaseViewController,TabbarProtocol{
    var employeeCollectionViewController: EmployeeCollectionViewController!
    var items : [EmployeeObject] = []
    @IBOutlet weak var headerTitle : UILabel!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmployeeCollectionViewController" {
            if let vc = segue.destination as? EmployeeCollectionViewController {
                self.employeeCollectionViewController = vc
                self.employeeCollectionViewController.items = self.items
                self.employeeCollectionViewController.callback = employeeCallback(item:)
            }
        }
    }
    override func reloadData() {
        headerTitle.text = getLanguageWithKey(key: "employeebilling")
    }
    
    override func setup() {
        super.setup()
    }
    
    func employeeCallback(item:EmployeeObject){
        let storyBoard: UIStoryboard = UIStoryboard(name: "employee", bundle:  nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "EmployeeDetailViewController") as! EmployeeDetailViewController
        vc.modalPresentationStyle = .fullScreen
        vc.employee = item
        vc.items = item.money!
        self.present(vc, animated: true)
        
    }
    

    
    @IBAction func back(_ sender : Any){
        dismiss(animated: true, completion: nil)
    }
}
