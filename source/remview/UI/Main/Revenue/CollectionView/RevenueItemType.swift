//
//  RevenueItemType.swift
//  remview
//
//  Created by Bui Si Quan on 25/04/2022.
//

import Foundation

class RevenueItemType {
    var name : String!
    var image : String!
    var type : RevenueCollectionViewController.type
    
    init(name:String,image:String,type:RevenueCollectionViewController.type) {
        self.name = name
        self.image = image
        self.type = type
    }
}
