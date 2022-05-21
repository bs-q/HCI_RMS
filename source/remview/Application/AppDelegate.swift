//
//  AppDelegate.swift
//  iService
//
//  Created by Admin on 6/17/21.
//

import UIKit
import Resolver
import GRDB
import Firebase
import DropDown
import GoogleMaps
import RxSwift
import RxRelay
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    @Injected
    var appCofig: AppConfiguration
    
    @AppUserDefault(key: "languageKey", defaultValue: "en")
    var languageKey: String!

    var currentRestaurant : Restaurant?
    var startDate = Date()
    var endDate = Date()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //override system font
        UIFont.overrideInitialize();
        
        //init language
        reloadLanguage()
        DropDown.startListeningToKeyboard()
        
        return true
    }

    
    func changeLaguage(lang: String!) {
        self.languageKey = lang
        reloadLanguage()
    }
    
    func reloadLanguage() {
        guard
            let path = Bundle.main.path(forResource: languageKey, ofType: "lproj"),
            let bundle = Bundle(path: path)
        else {
            appCofig.languageBundle = Bundle.main
            return
        }
        appCofig.languageBundle = bundle;
    }
    
}

extension Resolver {
    public static func registerApplicationContext() {
        register(AppDelegate.self) {
            return UIApplication.shared.delegate as? AppDelegate
        }.scope(.application)
        
        //register db
        register(DatabasePool.self) {
            do{
                // Create a DatabasePool for efficient multi-threading
                let databaseURL = try FileManager.default
                    .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                    .appendingPathComponent("db.sqlite")
                let dbPool = try DatabasePool(path: databaseURL.path)
                
                // Setup the database
                try AppDatabase().setup(dbPool)
                
                return dbPool
            }catch{
                return nil;
            }
        }.scope(.application)
    }
    
}
