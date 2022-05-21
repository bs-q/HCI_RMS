//
//  Tabbar+Extension.swift
//  agilemark
//
//  Created by _ on 16/12/2021.
//

import Foundation
import UIKit
class TabBar: UITabBar {

    override open func sizeThatFits(_ size: CGSize) -> CGSize {
            super.sizeThatFits(size)
            var sizeThatFits = super.sizeThatFits(size)
            sizeThatFits.height = 100
            return sizeThatFits
        }
}
