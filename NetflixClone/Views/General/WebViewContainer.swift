//
//  WebViewContainer.swift
//  NetflixClone
//
//  Created by Abhishek Tyagi on 04/02/24.
//

import Foundation
import WebKit
import SwiftUI
import SafariServices

class WebViewState : ObservableObject {
    @Published var showProgress: Bool = false
    @Published var estimatedProgress: Double = 0
}

struct WebViewContainer: UIViewRepresentable {
    var url: URL
    var webViewState : WebViewState
    var handler : ((Bool) -> Void)?
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.addObserver(context.coordinator, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(webViewState: webViewState) { state in
            handler?(state)
        }
    }
   
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var webViewState : WebViewState
        var handler : ((Bool) -> Void)
        
        init(webViewState : WebViewState, handler : @escaping ((Bool) -> Void) = { model in } ) {
            self.webViewState = webViewState
            self.handler = handler
        }
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == #keyPath(WKWebView.estimatedProgress),
               let webView = object as? WKWebView {
                webViewState.estimatedProgress = webView.estimatedProgress
            }
        }
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            webViewState.showProgress = true
        }
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webViewState.showProgress = false
        }
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            webViewState.showProgress = false
        }
    }
}




public struct SafariView: UIViewControllerRepresentable {

    let url: URL

   public func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

   public func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }

}
