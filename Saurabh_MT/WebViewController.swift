//
//  WebViewController.swift
//  Saurabh_MT
//
//  Created by saurabh srivastava on 29/07/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController,WKNavigationDelegate {
    var webView: WKWebView!
    var pageId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        var str = "https://en.wikipedia.org/?curid="+String(pageId)
        let url = URL(string: str)
        webView.load(URLRequest(url: url!))
        webView.allowsBackForwardNavigationGestures = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
