//
//  ViewControllerWKWebView2.swift
//  iOS-Keyboard-Shortcuts
//
//  Created by Chen Su on 3/30/18.
//  Copyright © 2018 Chen Su. All rights reserved.
//

import UIKit
import WebKit

class ViewControllerWKWebView2: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var contentView: UIView!
    
    override func loadView() {
        setupWebViewConfig()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        findContentView()
        loadExampleHtmlInWebView()

        configKeyboardShortcutsSpecial()
        NotificationCenter.default.addObserver(self, selector: #selector(configKeyboardShortcutsSpecial), name: .UIKeyboardDidShow, object: nil)
    }
    
    func findContentView() {
        for subview in webView.scrollView.subviews {
            if subview.classForCoder.description() == "WKContentView" {
                contentView = subview
            }
        }
    }

    func setupWebViewConfig() {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.userContentController.add(self, name: "EXAMPLE2")
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        self.view = webView
    }
    
    func loadExampleHtmlInWebView() {
        let path = Bundle.main.path(forResource: "example2", ofType: "html")
        let url = URL(fileURLWithPath: path!)
        let request = URLRequest(url: url)
        webView.load(request)
    }

    @objc func configKeyboardShortcutsSpecial() {
        contentView?.inputAssistantItem.leadingBarButtonGroups = []
        contentView?.inputAssistantItem.trailingBarButtonGroups = []
        
        contentView?.inputAssistantItem.leadingBarButtonGroups.append(generateLeadingBarButtonGroup())
        contentView?.inputAssistantItem.trailingBarButtonGroups.append(generateTrailingBarButtonGroup())
    }
    
    @objc func customButtonPressed() {
        print("button pressed!")
    }

    func generateLeadingBarButtonGroup() -> UIBarButtonItemGroup {
        let buttonLeading1: UIBarButtonItem = UIBarButtonItem(title: "Button L1", style: .plain, target: self, action: #selector(customButtonPressed))
        
        let buttonLeading2: UIBarButtonItem = UIBarButtonItem(title: "Button L2", style: .plain, target: self, action: #selector(customButtonPressed))
        buttonLeading2.image = UIImage(named: "Alert")!.withRenderingMode(.alwaysOriginal)
        
        return UIBarButtonItemGroup.init(barButtonItems: [buttonLeading1, buttonLeading2], representativeItem: nil)
    }

    func generateTrailingBarButtonGroup() -> UIBarButtonItemGroup {
        let buttonTrailing1: UIBarButtonItem = UIBarButtonItem(title: "Button T1", style: .plain, target: self, action: #selector(customButtonPressed))
        
        return UIBarButtonItemGroup.init(barButtonItems: [buttonTrailing1], representativeItem: nil)
    }

}

extension ViewControllerWKWebView2: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
}
