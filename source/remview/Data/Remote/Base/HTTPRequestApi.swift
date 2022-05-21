//
//  HTTPRequestApi.swift
//  iService
//
//  Created by Admin on 10/7/21.
//

import Alamofire
import RxSwift
import RxAlamofire
import SystemConfiguration
import Resolver
import ObjectMapper
import simd
import UIKit
import CoreTelephony

class HTTPRequestApi: NSObject {
    
    @Injected
    var appCofig: AppConfiguration    
    
    
    func get<T: Mappable>(path:String, query:[String:Any]?, type : Int = 0 ) -> Observable<T>? {
        return RxAlamofire.requestJSON(.get, appCofig.webUrlHub + path, parameters: query, encoding: URLEncoding.default, headers: generateHeader(type: type), interceptor: .none)
            .debug()
            .mapObject(type: T.self)
    }
    
    func post<T: Mappable>(path:String, body:[String:Any]?, type : Int = 0 )-> Observable<T>? {
        print(body as Any)
        return RxAlamofire.requestJSON(.post, appCofig.webUrlHub + path, parameters: body, encoding: JSONEncoding.default, headers: generateHeader(type: type), interceptor: .none)
            .debug()
            .mapObject(type: T.self)
        
    }
    
    func delete<T: Mappable>(path:String, body:[String:Any]?, type : Int = 0)-> Observable<T>? {
        print(body as Any)
        return RxAlamofire.requestJSON(.delete, appCofig.webUrlHub  + path, parameters: body, encoding: JSONEncoding.default, headers: generateHeader(type: type), interceptor: .none)
            .debug()
            .mapObject(type: T.self)
        
    }
    
    func put<T: Mappable>(path:String, body:[String:Any]?, type : Int = 0)-> Observable<T>? {
        print(body as Any)
        return RxAlamofire.requestJSON(.put, appCofig.webUrlHub + path, parameters: body, encoding: JSONEncoding.default, headers: generateHeader(type: type), interceptor: .none)
            .mapObject(type: T.self)
    }
    func upload<T: Mappable>(image:UIImage)-> Observable<T>? {
        return Observable<T>.create {
            observer in
            AF.upload(multipartFormData: {
                        MultipartFormData in
                
                MultipartFormData.append(image.pngData()!, withName: "avatar", fileName: "avatar.PNG", mimeType: "image/png")
//                        MultipartFormData.append("AVATAR".data(using: String.Encoding.utf8)!, withName: "type")
            
            }, to: self.appCofig.webUrlHub + "/v1/users/me", method: .put,headers: self.generateHeader(type: 0))
                        .responseJSON(completionHandler: {
                            response in
                            guard let value = Mapper<T>().map(JSONObject: response.value) else {
                                    observer.onError( NSError(
                                    domain: "",
                                    code: -1,
                                    userInfo: [NSLocalizedDescriptionKey: "ObjectMapper can't mapping"]
                                ))
                                return
                            }
                            observer.onNext(value)
                            observer.onCompleted()
                        })
            return Disposables.create()
        }
    }
    static var userAgent : String {
        return "Cyber++ \(DeviceHelper.appVersion); \(DeviceHelper.uuidString); \(UIDevice.current.systemName); \(CTTelephonyNetworkInfo().subscriberCellularProvider?.carrierName ?? "None"); Apple; \(DeviceHelper.devicesType); \(UIScreen.main.bounds.width)x\(UIScreen.main.bounds.height); \(NSLocale.current.identifier.uppercased()); \(UIDevice.current.systemVersion)"
    }
    /**
    Default : 0
    Ignore header : 1
     */
    private func generateHeader(type: Int?)-> HTTPHeaders{
        var headers: HTTPHeaders = [
            "Content-Type":"application/json",
            "Accept":"application/json",
            "Authorization":"Bearer "+(appCofig.appToken ?? ""),
            "user-agent": appCofig.userAgent
        ]
        if type == 1 {
            headers.remove(name: "Authorization")
        }

        return headers
    }
    
    func isInternetAvailable() -> Bool
        {
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }
            
            var flags = SCNetworkReachabilityFlags()
            
            if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
                
                return false
                
            }
            
            let isReachable = flags.contains(.reachable)
            let needsConnection = flags.contains(.connectionRequired)
            
            return (isReachable && !needsConnection)
        }
}
