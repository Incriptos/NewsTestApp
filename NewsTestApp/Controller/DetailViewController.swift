//
//  DetailViewController.swift
//  NewsTestApp
//
//  Created by Andrew Vashulenko on 27.02.2018.
//  Copyright © 2018 Andrew Vashulenko. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var webView: UIWebView!
    
    var url: URL = URL(string: "https://www.google.com")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNews(url: url)
    }

    func loadNews(url: URL) {
        let requestObj = URLRequest(url: url)
        webView.loadRequest(requestObj)
    }
    
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
 }
