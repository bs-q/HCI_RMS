//
//  EmployeeDetailCollectionViewController.swift
//  agilemark
//
//  Created by _ on 22/12/2021.
//

import Foundation
import UIKit
import Resolver
class EmployeeDetailCollectionViewController : UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    @Injected
    var appConfig : AppConfiguration
    
    @Injected
    var appDelegate : AppDelegate
    func getLanguageWithKey(key: String) -> String {
        return key.localized(bundle: appConfig.languageBundle)
    }
    var items : [Money] = []
    var setting : RestaurantSetting!
    @IBOutlet var mCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(EmployeeDetailItem.nib(), forCellWithReuseIdentifier: EmployeeDetailItem.id)
    }
}
extension EmployeeDetailCollectionViewController {
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (self.collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size*0.8)
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmployeeDetailItem.id, for: indexPath) as? EmployeeDetailItem else {
            fatalError("Unable to dequeue EmployeeDetailItem")
        }
        cell.name.text = items[indexPath.row].name
        let money = Double(items[indexPath.row].money!)/100
        let moneyString = money.toRestaurantMoney(setting: appDelegate.currentRestaurant!.getSetting())
       
        cell.money.text = moneyString
        return cell
    }
    
    
}
