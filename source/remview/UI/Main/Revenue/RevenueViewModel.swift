//
//  ProfileViewModel.swift
//  agilemark
//
//  Created by _ on 23/12/2021.
//

import Foundation
import UIKit
import Resolver

class RevenueViewModel: BaseViewModel {
    
    @Injected
    var accountService : AccountService
    
    func uploadImg(image:UIImage,onSuccess:((BaseResponse<ProfileResponse>?)->Void)?, onFail:((NSError)->Void)?){
        accountService.upload(image: image)?.subscribe(onNext: {
            (Obj) in
            if let response = Obj as BaseResponse<ProfileResponse>?{
                onSuccess?(response)
            }
        }, onError: {(Error) in
            onFail?(Error as NSError)
        }).disposed(by: disposeBag)
        }
}

