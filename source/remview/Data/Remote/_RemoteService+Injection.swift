//
//  _RemoteService+Injection.swift
//  iService
//
//  Created by Admin on 10/7/21.
//

import Foundation
import Resolver


extension Resolver {
    public static func registerRemoteService() {
        register { HTTPRequestApi() }.scope(.application)
        register { AccountService() }.scope(.application)
        register { HomeService() }.scope(.application)

    }
    
}
