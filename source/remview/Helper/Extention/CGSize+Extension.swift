//
//  CGSize+Extension.swift
//  MQRcode
//
//  Created by Admin on 9/16/21.
//  Copyright © 2021 HQ-MQRCode. All rights reserved.
//

import Foundation
import UIKit

extension CGSize {
    var scaledSize: CGSize {
        .init(width: width * UIScreen.main.scale, height: height * UIScreen.main.scale)
    }
}
