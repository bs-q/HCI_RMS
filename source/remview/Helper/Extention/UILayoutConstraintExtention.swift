//
//  UILayoutConstraintExtention.swift
//  Cyber
//
//  Created by Bui Si Quan on 04/03/2022.
//

import Foundation
import UIKit
extension NSLayoutConstraint {
    func change(multiplier: CGFloat) -> NSLayoutConstraint {
            let newConstraint = NSLayoutConstraint(item: firstItem,
                                                   attribute: firstAttribute,
                                                   relatedBy: relation,
                                                   toItem: secondItem,
                                                   attribute: secondAttribute,
                                                   multiplier: multiplier,
                                                   constant: constant)

            newConstraint.priority = self.priority

            NSLayoutConstraint.deactivate([self])
            NSLayoutConstraint.activate([newConstraint])
            return newConstraint
        }
}
