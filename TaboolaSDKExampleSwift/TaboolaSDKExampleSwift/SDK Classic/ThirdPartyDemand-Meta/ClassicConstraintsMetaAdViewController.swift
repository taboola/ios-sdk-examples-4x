//
//  ClassicConstraintsMetaAdViewController.swift
//  TaboolaSDKExampleSwift
//
//  Created by Sasa Jovanovic on 14.1.25..
//

import UIKit
import TaboolaSDK

class ClassicConstraintsMetaAdViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var widgetHolder: UIView!

    // TBLClassicPage holds Taboola Widgets/Feed for a specific view
    var classicPage: TBLClassicPage?
    
    // TBLClassicUnit object represnting Widget/Feed
    var taboolaWidgetPlacement: TBLClassicUnit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taboolaInit()
        self.view.backgroundColor = .systemBackground
    }
    
    func taboolaInit() {
        classicPage = TBLClassicPage.init(pageType: Constants.pageTypeArticle, pageUrl: Constants.pageUrl, delegate: self, scrollView: scrollView)
        
        taboolaWidgetPlacement = classicPage?.createUnit(withPlacementName: Constants.metaPlacement, mode: Constants.metaWidgetMode_1x1)
        taboolaWidgetPlacement?.extraProperties = ["audienceNetworkPlacementId": Constants.audienceNetworkPlacementId]


        if let taboolaWidgetPlacement = taboolaWidgetPlacement {
            taboolaWidgetPlacement.fetchContentOnly()
        }
        
        setTaboolaConstraintsToSuper()
    }
    
    func setTaboolaConstraintsToSuper() {
        if let taboolaWidgetPlacement = taboolaWidgetPlacement {
            widgetHolder.addSubview(taboolaWidgetPlacement)
            taboolaWidgetPlacement.translatesAutoresizingMaskIntoConstraints = false
            taboolaWidgetPlacement.topAnchor.constraint(equalTo: widgetHolder.topAnchor, constant: 0).isActive = true
            taboolaWidgetPlacement.bottomAnchor.constraint(equalTo: widgetHolder.bottomAnchor, constant: 0).isActive = true
            taboolaWidgetPlacement.leadingAnchor.constraint(equalTo: widgetHolder.leadingAnchor, constant: 0).isActive = true
            taboolaWidgetPlacement.trailingAnchor.constraint(equalTo: widgetHolder.trailingAnchor, constant: 0).isActive = true
        }
    }
}

extension ClassicConstraintsMetaAdViewController: TBLClassicPageDelegate {
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
