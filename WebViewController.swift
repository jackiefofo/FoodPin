//
//  ViewController.swift
//  HelloWord
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 Lai. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet var containerView: UIView!
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "http://www.appcoda.com/contact") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    }
