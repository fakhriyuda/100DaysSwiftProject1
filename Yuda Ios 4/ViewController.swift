//
//  ViewController.swift
//  Yuda Ios 4
//
//  Created by ISYS Macbook air 1 on 03/06/24.
//

import UIKit
import WebKit

struct GlobalList {
    var websites = ["wikipedia.org", "hackingwithswift.com"]
}

class ViewController: UIViewController, WKNavigationDelegate {
    var link: String?

    var webview : WKWebView!
    var progressView: UIProgressView!
    
    
    override func loadView() {
        webview = WKWebView()
        webview.navigationDelegate = self
        view = webview
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webview, action:#selector(webview.reload))
        let back = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: webview, action: #selector(webview.goBack))
        let forward = UIBarButtonItem(image: UIImage(systemName: "chevron.right"), style: .plain, target: webview, action: #selector(webview.goForward))
        
        toolbarItems = [progressButton, spacer,back,forward, refresh]
        navigationController?.isToolbarHidden = false
        
        let url = URL(string: "https://" + (link ?? ""))!
        webview.load(URLRequest(url: url))
        webview.allowsBackForwardNavigationGestures = true
        webview.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    @objc func openTapped(){
        let ac = UIAlertController(title: "Open...", message: nil, preferredStyle: .actionSheet)
        for website in GlobalList().websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        for ipad actually
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action : UIAlertAction){
        let url = URL(string: "https://" + action.title!)
        webview.load(URLRequest(url: url!))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        progressView.progress = Float(webview.estimatedProgress)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host{
            print(host)
            for website in GlobalList().websites {
                if host.contains(website){
                    print("CONTAINED KOK")
                    decisionHandler(.allow)
                    return
                }
            }
        }
        print("failed")
        decisionHandler(.cancel)
        let alert = UIAlertController(title: "Sorry", message: "This site is blocked", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .cancel))
        present(alert, animated: true)
        
    }
    
    


}

