//
//  RevenueDetailCollectionViewController.swift
//  agilemark
//
//  Created by _ on 22/12/2021.
//

import Foundation
import UIKit
import Resolver
class RevenueDetailCollectionViewController : UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    @Injected
    var appConfig : AppConfiguration
    func getLanguageWithKey(key: String) -> String {
        return key.localized(bundle: appConfig.languageBundle)
    }
    var items : [DayEventUnit] = []
    var setting : RestaurantSetting!
    @IBOutlet var mCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(RevenueDetailItem.nib(), forCellWithReuseIdentifier: RevenueDetailItem.id)
    }
}
extension RevenueDetailCollectionViewController {
    
    
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RevenueDetailItem.id, for: indexPath) as? RevenueDetailItem else {
            fatalError("Unable to dequeue RevenueDetailItem")
        }
        cell.name.text = items[indexPath.row].name
        cell.money.text = items[indexPath.row].totalMoney?.toRestaurantMoney(setting: setting)
        return cell
    }
    
    
}
