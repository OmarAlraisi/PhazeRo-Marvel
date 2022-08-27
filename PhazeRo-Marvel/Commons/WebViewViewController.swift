//
//  WebViewViewController.swift
//  PhazeRo-Marvel
//
//  Created by Omar Al Raisi on 26/08/2022.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var url = "https://developer.marvel.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: URL(string: url)!))
    }
}
