//
//  UICollectionView+Extension.swift
//  iService
//
//  Created by Admin on 10/5/21.
//

import Foundation
import UIKit

extension UICollectionView {

    func registerXibFile<T: UICollectionViewCell>(_ type: T.Type) {
        self.register(UINib(nibName: String(describing: T.self), bundle: nil), forCellWithReuseIdentifier: String(describing: T.self))
    }
    
}
