//
//  HomeService.swift
//  agilemark
//
//  Created by _ on 20/12/2021.
//

import Foundation
import Resolver
import RxSwift
import ObjectMapper

class HomeService: NSObject {
    
    @Injected
    var httpRestApi: HTTPRequestApi
    
    func verifyQrCode(request: VerifyQRCodeRequest) -> Observable<BaseResponse<VerifyQRCodeResponse>>? {
        return httpRestApi.post(path: "/v1/device/verify-qrcode", body: request.toParameters())
    }
    func verifyToken() -> Observable<BaseResponse<VerifyQRCodeResponse>>? {
        return httpRestApi.post(path: "/v1/device/verify-token", body: nil)
    }
    func listNews(pageNumber:Int,pageSize:Int) -> Observable<BaseResponsePage<NewsResponse>>? {
        return httpRestApi.get(path: "/v1/news/client-list", query: ["page":pageNumber,"size":pageSize])
    }
    
    func newsDetail(id:Int64) -> Observable<BaseResponse<NewsDetailResponse>>? {
        return httpRestApi.get(path: "/v1/news/client-get/\(id)", query: [:])
    }
}


