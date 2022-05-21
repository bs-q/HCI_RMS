//
//  HelpViewController.swift
//  agilemark
//
//  Created by _ on 22/12/2021.
//

import Foundation
import UIKit
import Resolver
import RxSwift
import ObjectMapper
import WebKit

class NewsViewController: BaseViewController,TabbarProtocol {
    @IBOutlet weak var headerTitle : UILabel!
    var viewmodel = NewsViewModel()
    var newsTableViewController: NewsTableViewController!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewsTableViewController" {
            if let vc = segue.destination as? NewsTableViewController {
                self.newsTableViewController = vc
                self.newsTableViewController.newsItemCallback = newsItemCallback(item:)
                self.newsTableViewController.loadMore = newsLoadMore
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        reloadData()
        self.startIndicator(msg: getLanguageWithKey(key: "loading_msg"))
        loadMoreNews(page: 0, size: 10)
        debug("current screen")
        myRootVc(vc: self)?.currentScreen = self
    }
    func newsItemCallback(item:NewsResponse){
        self.startIndicator(msg: getLanguageWithKey(key: "loading_msg"))
        viewmodel.getNewsDetail(id: item.id!, onSuccess: {[self] in
            stopIndicator()
            navigateToNewsDetail(id: (viewmodel.detail?.id)!,name:(viewmodel.detail?.title)!)
        }, onError: {[self] in
            handleRequestError()
        }, onNetworkError: {[self] in
            handleNetworkError()
        })
    }
    func navigateToNewsDetail(id:Int64,name:String){
        let storyBoard: UIStoryboard = UIStoryboard(name: "news", bundle:  nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.id = id.description
        vc.pageTitle = name
        self.present(vc, animated: true)
    }
    func newsLoadMore(){
        if viewmodel.item?.data?.hasNext() ?? false {
            loadMoreNews(page: (viewmodel.item?.data?.getNext())!, size: 10)
            debug("load more news")
            return
        }
        debug("no news left")
    }
    func loadMoreNews(page:Int,size:Int){
//        self.startIndicator(msg: self.getLanguageWithKey(key: "loading_msg"))
        viewmodel.getNews(page: page, size: size, onSuccess: {
            self.stopIndicator()
            self.newsTableViewController.newsList = (self.viewmodel.item?.data?.data)!
            self.newsTableViewController.tableView.reloadData()
        }, onError: {
//            self.handleRequestError()
        }, onNetworkError: {
//            self.handleNetworkError()
        })
        
    }
    override func reloadData() {
        headerTitle.text = getLanguageWithKey(key: "news")
    }
}
