//
//  RevenueCollectionViewController.swift
//  agilemark
//
//  Created by _ on 22/12/2021.
//

import Foundation
import UIKit
import Resolver
class RevenueCollectionViewController : UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    @Injected
    var appConfig : AppConfiguration
    func getLanguageWithKey(key: String) -> String {
        return key.localized(bundle: appConfig.languageBundle)
    }
    enum type {
        case revenueSell
        case revenueCancel
        case sortRevenue
        case sortMonth
        case sortMember
        case sortHouse
        case sortMachine
        case sortProduct
        case sortWeek
        case sortTime
        case sortType
    }
    
    var items : [Int:[RevenueItemType]] = [:] // section:cells
    var sectionName : [String] = ["sell_list","analytic"]
    var callback : ((_ item:RevenueItemType)->Void)!
    @IBOutlet var mCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        generateItem()
        self.collectionView.register(RevenueItem.nib(), forCellWithReuseIdentifier: RevenueItem.id)
        self.collectionView.register(RevenueHeaderItem.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RevenueHeaderItem.id)
        (self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionHeadersPinToVisibleBounds = true
        
    }
    func generateItem(){
        items[0] = [RevenueItemType(name: "revenuesale", image: "sale_icon", type: .revenueSell)
                    ,RevenueItemType(name: "revenuecancel", image: "cancel_icon", type: .revenueCancel)]
        items[1] = [RevenueItemType(name: "typeincome", image: "sort_type", type: .sortType)
                    ,RevenueItemType(name: "monthincome", image: "sort_revenue", type: .sortRevenue)
                    ,RevenueItemType(name: "incomedayofweek", image: "sort_month", type: .sortMonth)
                    ,RevenueItemType(name: "memberincome", image: "sort_member", type: .sortMember)
                    ,RevenueItemType(name: "houseincome", image: "sort_house", type: .sortHouse)
                    ,RevenueItemType(name: "machineincome", image: "sort_machine", type: .sortMachine)
                    ,RevenueItemType(name: "quantityincome", image: "sort_product", type: .sortProduct)
                    ,RevenueItemType(name: "weekincome", image: "sort_week", type: .sortWeek)
                    ,RevenueItemType(name: "incomehour", image: "sort_time", type: .sortTime)]
    }
}
extension RevenueCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        items.count
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items[section]!.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (self.collectionView.frame.size.width - space) / 2.0
        
        return CGSize(width: size, height: 120)
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RevenueItem.id, for: indexPath) as? RevenueItem else {
            fatalError("Unable to dequeue RevenueItem")
        }
        cell.item = items[indexPath.section]![indexPath.row]
        cell.callback = callback
        cell.name.text = getLanguageWithKey(key: cell.item.name)
        cell.image.image = UIImage(named: cell.item.image)
        return cell
    }
    
    
}
