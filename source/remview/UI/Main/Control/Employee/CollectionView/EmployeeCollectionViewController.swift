//
//  EmployeeCollectionViewController.swift
//  agilemark
//
//  Created by _ on 22/12/2021.
//

import Foundation
import UIKit
import Resolver
class EmployeeCollectionViewController : UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    @Injected
    var appConfig : AppConfiguration
    
    @Injected
    var appDelegate : AppDelegate
    func getLanguageWithKey(key: String) -> String {
        return key.localized(bundle: appConfig.languageBundle)
    }
    
    var items : [EmployeeObject] = []
    var callback : ((_ item:EmployeeObject)->Void)!
    @IBOutlet var mCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(EmployeeItem.nib(), forCellWithReuseIdentifier: EmployeeItem.id)
        
    }

}
extension EmployeeCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (self.collectionView.frame.size.width - space) / 2.0
        
        return CGSize(width: size, height: 120)
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmployeeItem.id, for: indexPath) as? EmployeeItem else {
            fatalError("Unable to dequeue EmployeeItem")
        }
        cell.item = items[indexPath.row]
        cell.callback = callback
        cell.type.text = cell.item.employeeName
        let money = (cell.item.money?.reduce(0, {$0 + (Double($1.money!) )}))!/100
        let moneyString = money.toRestaurantMoney(setting: appDelegate.currentRestaurant!.getSetting())
        cell.money.text = moneyString
        return cell
    }
    
    
}
