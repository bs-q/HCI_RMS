//
//  NewsTableViewController.swift.swift
//  agilemark
//
//  Created by _ on 20/12/2021.
//

import Foundation
import UIKit
import Resolver
class NewsTableViewController : UITableViewController {
    var loadMore : (()->Void)!
    
    @Injected
    var appConfig : AppConfiguration

    @IBOutlet var mTableView: UITableView!
    var newsList : [NewsResponse] = []
    var newsItemCallback : ((_ item:NewsResponse)->Void)!

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        self.tableView.register(NewsItem.nib(), forCellReuseIdentifier: NewsItem.id)
        
    }
}
extension NewsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        newsList.count
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 10
        }
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.size.width*1.1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsItem.id, for: indexPath) as? NewsItem else {
            fatalError("Unable to dequeue NewsItem")
        }
        cell.item = newsList[indexPath.section]
        cell.callback = newsItemCallback
        cell.title.text = cell.item.title
        cell.thumbnail.loadImageFromUrl(url: appConfig.webUrlHub + "/v1/file/download" + cell.item.avatar!)
        return cell
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section + 1 == newsList.count {
            loadMore()
        }
    }
}




