//
//  TabbarProtocol.swift
//  remview
//
//  Created by Bui Si Quan on 23/04/2022.
//

import Foundation
import UIKit
protocol TabbarProtocol {
   func myRootVc(vc : UIViewController) -> MainViewController?
}
extension TabbarProtocol {
    func myRootVc(vc : UIViewController) -> MainViewController? {
        return vc.tabBarController as? MainViewController
    }
}
