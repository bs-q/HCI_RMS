//
//  UIScrollView+Extention.swift
//  iService
//
//  Created by Admin on 10/5/21.
//

import Foundation
import UIKit


extension UIScrollView{
    func scrollToTop() {
        let scrollTo = CGPoint(x: 0, y: 0)
        setContentOffset(scrollTo, animated: false)
    }
    
    func scrollToBottom() {
        let desiredOffset = CGPoint(x: 0, y: contentSize.height)
        setContentOffset(desiredOffset, animated: false)
    }
}
