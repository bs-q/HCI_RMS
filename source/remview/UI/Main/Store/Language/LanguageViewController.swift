//
//  LanguageViewController.swift
//  remview
//
//  Created by Bui Si Quan on 25/04/2022.
//

import Foundation
import CoreGraphics
import UIKit
class LanguageViewController : BaseViewController {
    func reloadLanguageCallback(){
        getMainViewController()?.storeVc.reloadData()
        getMainViewController()?.reloadLanguage()
        getMainViewController()?.storeVc.storeTableViewController?.tableView.reloadData()
        if getMainViewController()?.revenueVc.load ?? false {
            getMainViewController()?.revenueVc.reloadData()
            getMainViewController()?.revenueVc.revenueCollectionViewController.collectionView.reloadData()
        }
        if getMainViewController()?.settingVc.load ?? false {
            getMainViewController()?.settingVc.reloadData()
            getMainViewController()?.settingVc.settingCollectionViewController.collectionView.reloadData()
        }
      
    }
    func getMainViewController()->MainViewController?{
        return self.presentingViewController as? MainViewController
    }
    @IBOutlet weak var vi : UILabel!
    @IBOutlet weak var en : UILabel!
    @IBOutlet weak var de : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setup() {
        super.setup()
    }
    override func reloadData() {
        vi.text = getLanguageWithKey(key: "vi")
        en.text = getLanguageWithKey(key: "en")
        de.text = getLanguageWithKey(key: "de")
    }
    
    @IBAction func vi(_ sender : Any){
        appDelegate.changeLaguage(lang: "vi")
        reloadLanguageCallback()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func en(_ sender : Any){
        appDelegate.changeLaguage(lang: "en")
        reloadLanguageCallback()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func de(_ sender : Any){
        appDelegate.changeLaguage(lang: "de")
        reloadLanguageCallback()
        dismiss(animated: true, completion: nil)
    }
    
}
