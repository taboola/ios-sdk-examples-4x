//
//  ClassicFrameScrollViewController.swift
//  TaboolaSDKExampleV4
//
//  Copyright © 2020 Taboola. All rights reserved.
//

import UIKit
import TaboolaSDK

class ClassicFrameScrollViewController: UIViewController {
    
    var scrollView: UIScrollView!
    
    var topText: UILabel = UILabel()
    var midText: UILabel = UILabel()

    // TBLClassicPage holds Taboola Widgets/Feed for a specific view
    var classicPage: TBLClassicPage?
    // TBLClassicUnit object represnting Widget/Feed
    var taboolaWidgetPlacement: TBLClassicUnit?
    var taboolaFeedPlacement: TBLClassicUnit?
    
    let screenSize: CGRect = UIScreen.main.bounds
    var didLoadWidget: Bool = false
    var didLoadFeed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        
        topText = UILabel(frame: screenSize)
        textCreator(labeToEdit: topText)
        
        scrollView.addSubview(topText)
        
        // Creating the Taboola page object
        taboolaInit()
        self.view.addSubview(scrollView)
    }
    
    func taboolaInit() {
        classicPage = TBLClassicPage.init(pageType: Constants.pageTypeArticle, pageUrl: Constants.pageUrl, delegate: self, scrollView: self.scrollView)
        
        // Creating the first Taboola object - Widget
        taboolaWidgetPlacement = classicPage?.createUnit(withPlacementName: Constants.placementBelowArticle, mode: Constants.widgetMode_1x4)
    
        if let taboolaWidgetPlacement = taboolaWidgetPlacement {
            // Creating the frame of the Widget
            taboolaWidgetPlacement.frame = CGRect(x: 0, y: topText.frame.size.height, width: self.view.frame.size.width, height: 200)
            
            self.scrollView.addSubview(taboolaWidgetPlacement)

            // Fetching content to recieve recommendations
            taboolaWidgetPlacement.fetchContent()
            
            // Setting the contentSize of the scrollView to include: midText height and the Widget height
            scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: topText.frame.size.height +  taboolaWidgetPlacement.placementHeight)
            
            // Creating the second Taboola object - Feed
            taboolaFeedPlacement = classicPage?.createUnit(withPlacementName: Constants.placementFeedWithoutVideo, mode: Constants.thumbsFeedMode)
            
            if let taboolaFeedPlacement = taboolaFeedPlacement {
                taboolaFeedPlacement.fetchContent()
                
                // Setting the contentSize of the scrollView to include: midText height, Widget height and Feed height
                scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: topText.frame.size.height +  taboolaWidgetPlacement.placementHeight + taboolaFeedPlacement.placementHeight)
            }
        }
    }
        
    func textCreator(labeToEdit: UILabel) {
        labeToEdit.text = Constants.textToAdd
        labeToEdit.numberOfLines = 0
        labeToEdit.lineBreakMode = NSLineBreakMode.byWordWrapping
        labeToEdit.sizeToFit()
    }
    
    func loadMidText(taboolaWidgetPlacement: TBLClassicUnit) {
        didLoadWidget = true
        midText = UILabel(frame: CGRect(x: 0, y: topText.frame.size.height + taboolaWidgetPlacement.placementHeight, width: screenSize.width, height: screenSize.height))
        textCreator(labeToEdit: midText)
        scrollView.addSubview(midText)
    }
}

extension ClassicFrameScrollViewController: TBLClassicPageDelegate {
    func classicUnit(_ classicUnit: UIView!, didLoadOrResizePlacementName placementName: String!, height: CGFloat, placementType: PlacementType) {
        print("Placement name: \(String(describing: placementName)) has been loaded with height: \(height)")
        if placementName == Constants.placementBelowArticle {
            if let taboolaWidgetPlacement = taboolaWidgetPlacement {
                taboolaWidgetPlacement.frame = CGRect(x: 0, y: topText.frame.size.height, width: self.view.frame.size.width, height: taboolaWidgetPlacement.placementHeight)

                // Adding mid article widget to the ScrollView
                if taboolaWidgetPlacement.placementHeight > 0 && !didLoadWidget {
                    loadMidText(taboolaWidgetPlacement: taboolaWidgetPlacement)
                }
                
            scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: topText.frame.size.height + taboolaWidgetPlacement.placementHeight + midText.frame.size.height)
            }
        } else {
            if let taboolaFeedPlacement = taboolaFeedPlacement {
                taboolaFeedPlacement.frame = CGRect(x: 0, y: topText.frame.size.height + (taboolaWidgetPlacement?.placementHeight ?? 0) + midText.frame.size.height, width: self.view.frame.size.width, height: taboolaFeedPlacement.placementHeight)
                
                if !didLoadFeed {
                    didLoadFeed = true
                    scrollView.addSubview(taboolaFeedPlacement)
                }
                
                // Setting the contentSize of the scrollView to include: topText height, mid-article Widget height, midText height, Feed
                scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: topText.frame.size.height + (taboolaWidgetPlacement?.placementHeight ?? 0) + midText.frame.size.height + taboolaFeedPlacement.placementHeight)
            }
        }
    }
    
    func classicUnit(_ classicUnit: UIView!, didFailToLoadPlacementName placementName: String!, errorMessage error: String!) {
        print(error as Any)
    }
    
    func classicUnit(_ classicUnit: UIView!, didClickPlacementName placementName: String!, itemId: String!, clickUrl: String!, isOrganic organic: Bool, customData: [AnyHashable : Any]!) -> Bool {
        return true
    }
}
