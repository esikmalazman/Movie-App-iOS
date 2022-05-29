//
//  StaticPageVC.swift
//  MovieApp-TakeHomeProject
//
//  Created by Ikmal Azman on 18/05/2022.
//

import UIKit
import WebKit

class WebViewController : UIViewController {
    
    private let webView = WKWebView()
    let urlString : String
    
    init(urlString : String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.addSubview(webView)
        webView.frame = view.bounds
        webView.navigationDelegate = self
    }
}

extension WebViewController :  WKNavigationDelegate {}
