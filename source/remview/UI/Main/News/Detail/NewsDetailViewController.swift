//
//  NewsDetailViewController.swift
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

class NewsDetailViewController: BaseViewController,WKNavigationDelegate,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var mWebView: WKWebView!
    @IBOutlet weak var webTitle: UILabel!

    var webviewLoad = false
    var id : String!
    var pageTitle : String!
    var leftPanTriggered: Bool = false
    
    override func setup() {
        webTitle.text = pageTitle
        mWebView.navigationDelegate = self
        mWebView.configuration.preferences.javaScriptEnabled = true
        mWebView.isHidden = true
        let edgeGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(userSwipedFromEdge(sender:)))
        edgeGestureRecognizer.edges = UIRectEdge.left
        edgeGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(edgeGestureRecognizer)
    }
    @objc func userSwipedFromEdge(sender: UIScreenEdgePanGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            if !leftPanTriggered {
                let threshold: CGFloat = self.view.frame.width*0.8
                let translation = abs(sender.translation(in: view).x)
                self.view.transform = CGAffineTransform(translationX: translation, y: 0)
                if translation >= threshold  {
                    
                    dismiss(animated: false, completion: nil)
                    leftPanTriggered = true
                }
            }
        case .ended, .failed, .cancelled:
            leftPanTriggered = false
            UIView.animate(withDuration: 0.3, animations: {
                self.view.transform = .identity
            })
        default: break
        }
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        delay(second: 0.321, run: {
            self.mWebView.isHidden =  false
            self.view.backgroundColor = .clear
            self.webviewLoad = true
            self.stopIndicator()
        })
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.stopIndicator()
        makeToast(title: nil, msg: "Error occurred, please try again")
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !webviewLoad {
            self.startIndicator(msg: "Loading, please wait...")
            let myURL = URL(string:appCofig.webUrl+"/news-detail?id="+id)
            let myRequest = URLRequest(url: myURL!)
            mWebView.load(myRequest)
        }
    }
    override func registerKeyboardListener() {
        // remove kb listener
        
    }
    
    
    @IBAction func back(_ sender : Any){
        dismiss(animated: true, completion: nil)
    }
    
}
