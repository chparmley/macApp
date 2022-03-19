//
//  BrowserView.swift
//  macApp
//
//  Created by Charles Parmley on 3/18/22.
//

import Foundation
import SwiftUI
import WebKit


struct SwiftUIWebView: NSViewRepresentable {
    let url: URL?
    
    func makeNSView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }
    func updateNSView(_ nsView: WKWebView, context: Context) {
        guard let myURL = url else {
            return
        }
        nsView.load(URLRequest(url: myURL))
    }
}
    




