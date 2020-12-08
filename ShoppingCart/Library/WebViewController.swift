//
//  WebViewController.swift
//  ShoppingCart
//
//  Created by Aswani G on 8/2/20.
//

import UIKit
import WebKit
import SwiftUI

class WebViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    let closeButton = UIHostingController(rootView: CloseButton())
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        let myURL = URL(string: "http://www.google.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        webView.allowsBackForwardNavigationGestures = true
        addChild(closeButton)
        webView.addSubview(closeButton.view)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.closeAction))
        closeButton.view.addGestureRecognizer(tap)
        closeButton.didMove(toParent: self)
    }
    
    @objc private func closeAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
