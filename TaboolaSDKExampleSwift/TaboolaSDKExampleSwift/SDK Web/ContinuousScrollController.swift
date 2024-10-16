//
//  ContinuousScrollController.swift
//  TaboolaSDKExampleSwift
//
//  Created by Moshe Lavie on 05/09/2022.
//  Copyright © 2022 Liad Elidan. All rights reserved.
//

import Foundation
import TaboolaSDK


class ContinuousScrollController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var webViewContainer2: UIView!
    
    var webView = WKWebView()
    // The TBLWebPage object that will contain the Taboola content fetched via JS
    var webPage: TBLWebPage?
    var webUnit: TBLWebUnit?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.frame = view.frame
        webViewContainer2.addSubview(webView)
        
        webPage =  TBLWebPage.init(delegate: self)
        webUnit = webPage?.createUnit(with: webView)
                
        try? loadExamplePage()
    }
    
    func loadExamplePage() throws {
        guard let htmlPath = Bundle.main.path(forResource: "SampleContinuousScrollPage", ofType: "html") else {
            print("Error loading HTML")
            return
        }
        let appHtml = try String.init(contentsOfFile: htmlPath, encoding: .utf8)
        webView.loadHTMLString(appHtml, baseURL: URL(string: "https://cdn.taboola.com/mobile-sdk/init/"))
    }
}

extension ContinuousScrollController: TBLWebPageDelegate {
    func webView(_ webView: WKWebView!, didLoadPlacementName placementName: String!, height: CGFloat) {
        print("Placement name: \(String(describing: placementName)) has been loaded with height: \(height)")
    }
    
    func webView(_ webView: WKWebView!, didFailToLoadPlacementName placementName: String!, errorMessage error: String!) {
        print("Placement name: \(String(describing: placementName)) failed to load!)")
        print("Error: \(String(describing: error))")
    }
    
    func webView(_ webView: WKWebView!, didClickPlacementName placementName: String!, itemId: String!, clickUrl: String!, isOrganic organic: Bool) -> Bool {
        // Return 'true' for Taboola SDK to handle the click event (default behavior).
        // Return 'false' to handle the click event yourself. (Applicable for organic content only.)
        return true
    }
    
    func webView(_ webView: WKWebView!, didClickPlacementName placementName: String!, itemId: String!, clickUrl: String!, isOrganic organic: Bool, customData: [AnyHashable : Any]!) -> Bool{
        // Return 'true' for Taboola SDK to handle the click event (default behavior).
        // Return 'NO' to handle the click event yourself. (Applicable for organic content only (including Audience Exchange items).)
        
        // You can identify Audience Exchange items by checking the customData dictionary
        // Note that you will also need to pass in an Extra Property flag called allowAudienceExchangeClickOverride with the value of true
        if let isAudienceExchange = customData["isAudienceExchange"] as? Bool {
            if isAudienceExchange == true {
                // Handle Audience Exchange items
                return false
            }
        }

        
        return true
    }
}
