//
//  WebViewController.swift
//  ios-rotation-sandbox
//
//  Created by mono on 4/29/15.
//  Copyright (c) 2015 mono. All rights reserved.
//

import Foundation
import WebKit
import UIKit
class WebViewController: UIViewController, WKNavigationDelegate {
    
    private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func configureWebView() {
        let controller = WKUserContentController()
        let config = WKWebViewConfiguration()
        config.userContentController = controller
        webView = WKWebView(frame: view.bounds, configuration: config)
        webView.navigationDelegate = self
        view.insertSubview(webView, atIndex: 0)
        webView.bindToSuperView()
        let request = NSURLRequest(URL: NSURL(string: "https://www.youtube.com/watch?v=GT9-G6oiJtI")!)
        webView.loadRequest(request)
    }
}