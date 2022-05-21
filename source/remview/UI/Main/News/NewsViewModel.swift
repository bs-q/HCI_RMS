//
//  HelpViewModel.swift
//  agilemark
//
//  Created by _ on 22/12/2021.
//

import UIKit
import Resolver

class NewsViewModel: BaseViewModel {
    var item : BaseResponsePage<NewsResponse>?
    var detail : NewsDetailResponse?
    func getNews(page:Int,size:Int,onSuccess:@escaping ()->Void,onError:@escaping ()->Void, onNetworkError:@escaping ()->Void){
        homeService.listNews(pageNumber: page, pageSize: size)?.subscribe(onNext: {result in
            if result.data != nil{
                if self.item == nil {
                    self.item = result
                } else {
                    self.item?.data?.copy(newData: result.data!)
                }
                onSuccess()
            } else {
                onError()
            }
        }, onError: {error in
            onNetworkError()
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    func getNewsDetail(id:Int64,onSuccess:@escaping ()->Void,onError:@escaping ()->Void, onNetworkError:@escaping ()->Void){
        homeService.newsDetail(id: id)?.subscribe(onNext: {result in
            if result.data != nil{
                self.detail = result.data
                onSuccess()
            } else {
                onError()
            }
        }, onError: {error in
            onNetworkError()
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
}
