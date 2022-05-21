
//  AppConfiguration.swift
//  iService
//
//  Created by Admin on 9/16/21.
//


import Foundation
import Resolver

final class AppConfiguration {
    lazy var apiUrl: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiUrl") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        return apiKey
    }()
    
    var webUrlHub: String{
        get{
            #if DEBUG
                return "https://remview-api.developteam.net"
            #else
                return "https://remview-api.developteam.net"
            #endif
            
        }
    }
    var socketUrl: String{
        get{
            #if DEBUG
                return "wss://remview-socket.developteam.net/ws"

            #else
                return "wss://remview-socket.developteam.net/ws"
            #endif
            
        }
    }
    var webUrl : String {
        get{
            #if DEBUG
                return "https://remview-admin.developteam.net"

            #else
                return "https://remview-admin.developteam.net"
            #endif
            
        }
    }
    
    var userAgent = HTTPRequestApi.userAgent
    
    
    var screenWidth = UIScreen.main.bounds.size.width;
    var screenHeight = UIScreen.main.bounds.size.height;
    var backgroundColor: UIColor = UIColor().hexColor(hex: "#ffffff")
    
    var appToken: String!
    
    var languageBundle: Bundle = Bundle.main
    
    var deviceId = DeviceHelper.uuidString
}

extension Resolver {
    public static func registerApplicationConfiguration() {
        register(AppConfiguration.self) {
            return AppConfiguration()
        }.scope(.application)
    }
    
}
