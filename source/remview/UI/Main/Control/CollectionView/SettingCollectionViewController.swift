//
//  SettingCollectionViewController.swift
//  agilemark
//
//  Created by _ on 22/12/2021.
//

import Foundation
import UIKit
import Resolver
class SettingCollectionViewController : UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    @Injected
    var appConfig : AppConfiguration
    func getLanguageWithKey(key: String) -> String {
        return key.localized(bundle: appConfig.languageBundle)
    }
    enum type {
        case printInvoice
        case employeeBilling
        case turnOnTeamView
        case turnOnTunnel
    }
    
    var items : [Int:[SettingItemType]] = [:] // section:cells
    var callback : ((_ item:SettingItemType)->Void)!
    var sectionName : [String] = ["employeepayment","summaryofdaysandmonths","permission","edititem"]

    @IBOutlet var mCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        generateItem()
        self.collectionView.register(SettingItem.nib(), forCellWithReuseIdentifier: SettingItem.id)
        self.collectionView.register(RevenueHeaderItem.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RevenueHeaderItem.id)
    }
    func generateItem(){
        items[0] = [SettingItemType(name: "employeemoney", image: "revenue_icon", type: .employeeBilling)
                    ,SettingItemType(name: "printbill", image: "revenue_icon", type: .printInvoice)
                    ,SettingItemType(name: "editpermission", image: "revenue_icon", type: .turnOnTeamView)
                    ,SettingItemType(name: "edititem", image: "revenue_icon", type: .turnOnTunnel)]
    }
}
extension SettingCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (self.collectionView.frame.size.width - space)
        return CGSize(width: size, height: 120)
        
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RevenueHeaderItem.id, for: indexPath)
        if let h = header as? RevenueHeaderItem {
            h.name.text = getLanguageWithKey(key: sectionName[indexPath.section])
        }
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingItem.id, for: indexPath) as? SettingItem else {
            fatalError("Unable to dequeue SettingItem")
        }
        cell.item = items[0]![indexPath.section]
        cell.callback = callback
        cell.name.text = getLanguageWithKey(key: cell.item.name)
        cell.image.image = UIImage(named: cell.item.image)
        return cell
    }
    
    
}
