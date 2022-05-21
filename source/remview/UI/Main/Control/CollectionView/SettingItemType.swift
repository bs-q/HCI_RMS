//
//  RevenueItemType.swift
//  remview
//
//  Created by Bui Si Quan on 25/04/2022.
//

import Foundation

class SettingItemType {
    var name : String!
    var image : String!
    var type : SettingCollectionViewController.type
    
    init(name:String,image:String,type:SettingCollectionViewController.type) {
        self.name = name
        self.image = image
        self.type = type
    }
}
