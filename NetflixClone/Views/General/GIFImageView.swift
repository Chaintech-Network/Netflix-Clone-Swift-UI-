//
//  GIFImageView.swift
//  NetflixClone
//
//  Created by Abhishek Tyagi on 02/04/24.
//

import SwiftUI
import WebKit

enum URLType {
  case name(String) // local file name of gif
  case url(URL) // remote url

  var url: URL? {
    switch self {
      case .name(let name):
        return Bundle.main.url(forResource: name, withExtension: "gif")
      case .url(let remoteURL):
        return remoteURL
    }
  }
}

struct GIFImageView: UIViewRepresentable {
    private let name: String
    init(_ name: String) {
        self.name = name
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        
        webview.load(data,mimeType: "image/gif",characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent())
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
}
