//
//  ClassicInterstitialController.swift
//  TaboolaSDKExampleSwift
//
//  Created by Avi Nisan Shevim on 05/03/2026.
//  Copyright © 2026 Taboola. All rights reserved.
//

import UIKit
import TaboolaSDK

class ClassicInterstitialController: UIViewController {
    @IBOutlet private var showButton: UIButton!
    
    var classicPage: TBLClassicPage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showButton.isEnabled = false
        
        self.taboolaInit()
    }
    
    @IBAction func showButtonTapped(_ sender: Any) {
        classicPage?.showInterstitial()
    }
    
    private func taboolaInit() {
        classicPage = TBLClassicPage(pageType:Constants.pageTypeArticle,
                                     pageUrl:Constants.pageUrl,
                                     delegate:self,
                                     scrollView:nil)
        
        classicPage?.initInterstitial(withPlacement: Constants.placementInterstitial,
                                      mode: Constants.widgetMode_5050,
                                      delegate: self,
                                      customSegment: nil)

        classicPage?.loadInterstitial()
    }
}

extension ClassicInterstitialController: TBLClassicInterstitialDelegate {
    func interstitialDidLoadAd() {
        print("✅ Interstitial loaded successfully")
        
        self.showButton.isEnabled = true
    }
    
    func interstitialWillPresent() {
        print("Interstitial will present");
    }
    
    func interstitialDidPresent() {
        print("Interstitial presented");
    }
    
    func interstitialWillDismiss() {
        print("Interstitial will dismiss");
    }
    
    func interstitialDidDismiss() {
        print("Interstitial dismissed");
    }
    
    func interstitialDidReceiveTapEvent() {
        print("Interstitial received tap event");
    }
    
    func interstitialDidFailToLoadAdWithError(_ error: String!) {
        print("⚠️ Interstitial failed to load: %", error!);

        self.showButton.isEnabled = false
    }
    
}
