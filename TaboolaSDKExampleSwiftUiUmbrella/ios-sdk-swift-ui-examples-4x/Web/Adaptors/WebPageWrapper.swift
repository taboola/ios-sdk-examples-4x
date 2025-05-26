//
//  WebPageWrapper.swift
//  QAApp
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import Foundation
import TaboolaSDK
import TaboolaSDK_SwiftUI_Umbrella

class WebPageWrapper: NSObject, WebPageWrappable {
    
    var page: TBLWebPage!
    
    override init() {
        super.init()
        
        page = TBLWebPage(delegate: self)
        page.pageExtraProperties = ["testWebKey":"testWebValue"]
    }
}

extension WebPageWrapper: TBLWebPageDelegate {
    func webView(_ webView: WKWebView!,
                 didClickPlacementName placementName: String!,
                 itemId: String!,
                 clickUrl: String!,
                 isOrganic organic: Bool) -> Bool {
        // Return 'true' for Taboola SDK to handle the click event (default behavior).
        // Return 'false' to handle the click event yourself. (Applicable for organic content only.)
        return true
    }
    
    func webView(_ webView: WKWebView!, didLoadPlacementName placementName: String!, height: CGFloat) {
        print(String(describing: placementName))
    }
    
    func webView(_ webView: WKWebView!,
                 didFailToLoadPlacementName placementName: String!,
                 errorMessage error: String!) {
        print(error.debugDescription)
    }
}
