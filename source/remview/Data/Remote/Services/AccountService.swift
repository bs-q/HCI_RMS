//
//  AccountService.swift
//  iService
//
//  Created by Admin on 10/7/21.
//

import Foundation
import Resolver
import RxSwift
import ObjectMapper

class AccountService: NSObject {
    
    @Injected
    var httpRestApi: HTTPRequestApi
       
    func login(loginRequest: LoginRequest) -> Observable<BaseResponse<LoginResponse>>? {
        return httpRestApi.post(path: "/v1/users/login", body: loginRequest.toParameters())
    }
    
    func profile() -> Observable<BaseResponse<ProfileResponse>>? {
        return httpRestApi.get(path: "/v1/users/me", query: [:])
    }
    func verifyToken(verifyTokenRequest: VerifyTokenRequest) -> Observable<BaseResponse<VerifyTokenResponse>>? {
        return httpRestApi.post(path: "/v1/users/otp/verify", body:verifyTokenRequest.toParameters())
    }
  
//    func updateProfile(updateProfileRequest: UpdateProfileRequest) -> Observable<BaseResponse<UpdateProfileResponse>>? {
//        return httpRestApi.put(path: "/v1/customer/update-profile", body: updateProfileRequest.toParameters())
//    }
    func upload(image:UIImage)-> Observable<BaseResponse<ProfileResponse>>? {
        return httpRestApi.upload(image: image)
    }

}
