//
//  ScreenCoordinator.swift
//  MQRcode
//
//  Created by Nguyen Hoang on 10/16/20.
//

import UIKit

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

enum ScreenCoordinator {

    static func topViewController(_ viewController: UIViewController? = nil) -> BaseViewController? {
    
        let keyWindow = UIWindow.key
        let vc = viewController ?? keyWindow?.rootViewController
        if let navigationController = vc as? UINavigationController {
            return topViewController(navigationController.topViewController)
        } else if let tabBarController = vc as? UITabBarController {
            return tabBarController.presentedViewController != nil ? topViewController(tabBarController.presentedViewController) : topViewController(tabBarController.selectedViewController)
            
        } else if let presentedViewController = vc?.presentedViewController {
            return topViewController(presentedViewController)
        }
        return vc as? BaseViewController
    }
  
   
}
