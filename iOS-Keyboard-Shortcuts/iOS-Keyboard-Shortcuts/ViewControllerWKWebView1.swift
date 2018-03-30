//
//  ViewControllerWKWebView1.swift
//  iOS-Keyboard-Shortcuts
//
//  Created by Chen Su on 3/30/18.
//  Copyright © 2018 Chen Su. All rights reserved.
//

import UIKit
import WebKit

class ViewControllerWKWebView1: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebViewConfig()
        loadExampleHtmlInWebView()
        configKeyboardShortcuts()
    }

    func setupWebViewConfig() {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.userContentController.add(self, name: "EXAMPLE1")
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        self.view = webView
    }
    
    func loadExampleHtmlInWebView() {
        let path = Bundle.main.path(forResource: "example1", ofType: "html")
        let url = URL(fileURLWithPath: path!)
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func configKeyboardShortcuts() {
        webView.inputAssistantItem.leadingBarButtonGroups = []
        webView.inputAssistantItem.trailingBarButtonGroups = []
        
        let buttonLeading1: UIBarButtonItem = UIBarButtonItem(title: "Button L1", style: .plain, target: self, action: #selector(customButtonPressed))
        
        let buttonLeading2: UIBarButtonItem = UIBarButtonItem(title: "Button L2", style: .plain, target: self, action: #selector(customButtonPressed))
        buttonLeading2.image = UIImage(named: "Alert")!.withRenderingMode(.alwaysOriginal)

        let buttonTrailing1: UIBarButtonItem = UIBarButtonItem(title: "Button T1", style: .plain, target: self, action: #selector(customButtonPressed))

        
        let groupLeading: UIBarButtonItemGroup = UIBarButtonItemGroup.init(barButtonItems: [buttonLeading1, buttonLeading2], representativeItem: nil)
        let groupTrailing: UIBarButtonItemGroup = UIBarButtonItemGroup.init(barButtonItems: [buttonTrailing1], representativeItem: nil)
        
        webView.inputAssistantItem.leadingBarButtonGroups.append(groupLeading)
        webView.inputAssistantItem.trailingBarButtonGroups.append(groupTrailing)
    }
    
    @objc func customButtonPressed() {
        print("button pressed!")
    }
}

extension ViewControllerWKWebView1: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
}
