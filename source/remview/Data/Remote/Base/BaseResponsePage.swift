//
//  BaseResponseList.swift
//  agilemark
//
//  Created by _ on 20/12/2021.
//

import Foundation
import Foundation
import ObjectMapper


class BaseResponsePage<T: Mappable>: Mappable {
    var result : Bool?
    var data: Data<T>?
    var message : String?
    
    class Data<T:Mappable> : Mappable {
        var data : [T]?
        var totalPage : Int?
        var totalElements : Int?
        var page : Int?
        
        func hasNext() -> Bool{
            return totalPage! - 1 > page!;
        }
        func getNext() -> Int{
            return page! + 1
        }
        func copy(newData : Data){
            page = newData.page
            totalPage = newData.totalPage
            totalElements = newData.totalElements
            data!.append(contentsOf: newData.data!)
        }
        required init?(map: Map) {
        }
        init() {
            data = []
        }
        
        func mapping(map: Map) {
            totalPage <- map["totalPage"]
            data <- map["data"]
            page <- map["page"]
            totalElements <- map["totalElements"]

        }
    }
    
    required init?(map: Map) {
        
    }
    init() {
        
    }
    
    func mapping(map: Map) {
        result <- map["result"]
        data <- map["data"]
        message <- map["message"]

    }
}
