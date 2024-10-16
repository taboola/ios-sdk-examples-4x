//
//  ClassicConstraintsScrollViewController.swift
//  TaboolaSDKExampleV4
//
//  Copyright © 2020 Taboola. All rights reserved.
//

import UIKit
import TaboolaSDK

class ClassicConstraintsScrollViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var topWidget: UIView!
    @IBOutlet weak var bottomFeed: UIView!

    // TBLClassicPage holds Taboola Widgets/Feed for a specific view
    var classicPage: TBLClassicPage?
    
    // TBLClassicUnit object represnting Widget/Feed
    var taboolaWidgetPlacement: TBLClassicUnit?
    var taboolaFeedPlacement: TBLClassicUnit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taboolaInit()
    }
    
    func taboolaInit() {
        classicPage = TBLClassicPage.init(pageType: Constants.pageTypeArticle, pageUrl: Constants.pageUrl, delegate: self, scrollView: scrollView)
        
        taboolaWidgetPlacement = classicPage?.createUnit(withPlacementName: Constants.placementAboveArticle, mode: Constants.widgetMode_1x1)
        
        taboolaFeedPlacement = classicPage?.createUnit(withPlacementName: Constants.placementFeedWithoutVideo, mode: Constants.thumbsFeedMode)

        if let taboolaWidgetPlacement = taboolaWidgetPlacement {
            taboolaWidgetPlacement.fetchContent()
        }
        
        if let taboolaFeedPlacement = taboolaFeedPlacement {
            taboolaFeedPlacement.clipsToBounds = true
            taboolaFeedPlacement.fetchContent()
        }
        
        setTaboolaConstraintsToSuper()
    }
    
    func setTaboolaConstraintsToSuper() {
        if let taboolaWidgetPlacement = taboolaWidgetPlacement {
            topWidget.addSubview(taboolaWidgetPlacement)
            taboolaWidgetPlacement.translatesAutoresizingMaskIntoConstraints = false
            taboolaWidgetPlacement.topAnchor.constraint(equalTo: topWidget.topAnchor, constant: 0).isActive = true
            taboolaWidgetPlacement.bottomAnchor.constraint(equalTo: topWidget.bottomAnchor, constant: 0).isActive = true
            taboolaWidgetPlacement.leadingAnchor.constraint(equalTo: topWidget.leadingAnchor, constant: 0).isActive = true
            taboolaWidgetPlacement.trailingAnchor.constraint(equalTo: topWidget.trailingAnchor, constant: 0).isActive = true
        }
        
        if let taboolaFeedPlacement = taboolaFeedPlacement {
            bottomFeed.addSubview(taboolaFeedPlacement)
            taboolaFeedPlacement.translatesAutoresizingMaskIntoConstraints = false
            taboolaFeedPlacement.topAnchor.constraint(equalTo: bottomFeed.topAnchor, constant: 0).isActive = true
            taboolaFeedPlacement.bottomAnchor.constraint(equalTo: bottomFeed.bottomAnchor, constant: 0).isActive = true
            taboolaFeedPlacement.leadingAnchor.constraint(equalTo: bottomFeed.leadingAnchor, constant: 0).isActive = true
            taboolaFeedPlacement.trailingAnchor.constraint(equalTo: bottomFeed.trailingAnchor, constant: 0).isActive = true
        }
    }
}

extension ClassicConstraintsScrollViewController: TBLClassicPageDelegate {
    func classicUnit(_ classicUnit: UIView!, didLoadOrResizePlacementName placementName: String!, height: CGFloat, placementType: PlacementType) {
        print("Placement name: \(String(describing: placementName)) has been loaded with height: \(height)")
    }
    
    func classicUnit(_ classicUnit: UIView!, didFailToLoadPlacementName placementName: String!, errorMessage error: String!) {
        print(error as Any)
    }
    
    func classicUnit(_ classicUnit: UIView!, didClickPlacementName placementName: String!, itemId: String!, clickUrl: String!, isOrganic organic: Bool, customData: [AnyHashable : Any]!) -> Bool {
        return true
    }
}
