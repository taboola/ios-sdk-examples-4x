//
//  ClassicFrameMetaAdController.swift
//  TaboolaSDKExampleV4
//
//  Created by Sasa Jovanovic on 13.1.25..
//

import UIKit
import TaboolaSDK

class ClassicFrameMetaAdController: UIViewController {
    var scrollView: UIScrollView!
    
    var topText: UILabel = UILabel()
    var midText: UILabel = UILabel()
    
    // TBLClassicPage holds Taboola Widgets/Feed for a specific view
    var classicPage: TBLClassicPage?
    // TBLClassicUnit object represnting Widget/Feed
    var taboolaWidgetPlacement: TBLClassicUnit?
    
    let screenSize: CGRect = UIScreen.main.bounds
    var didLoadWidget: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
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
        
        // Creating Taboola object - Widget
        taboolaWidgetPlacement = classicPage?.createUnit(withPlacementName: Constants.metaPlacement, mode: Constants.metaWidgetMode_1x1)
        // Set unit extra prperty for audienceNetworkPlacementId, requiered for Meta ads
        taboolaWidgetPlacement?.extraProperties = ["audienceNetworkPlacementId": Constants.audienceNetworkPlacementId]
        
        if let taboolaWidgetPlacement = taboolaWidgetPlacement {
            // Creating the frame of the Widget
            taboolaWidgetPlacement.frame = CGRect(x: 0, y: topText.frame.size.height, width: self.view.frame.size.width, height: 200)
                        self.scrollView.addSubview(taboolaWidgetPlacement)
            
            // Fetching content to recieve recommendations
            taboolaWidgetPlacement.fetchContentOnly()
            
            // Setting the contentSize of the scrollView to include: midText height and the Widget height
            scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: topText.frame.size.height +  taboolaWidgetPlacement.placementHeight)
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

extension ClassicFrameMetaAdController: TBLClassicPageDelegate {
    func classicUnit(_ classicUnit: UIView!, didLoadOrResizePlacementName placementName: String!, height: CGFloat, placementType: PlacementType) {
        print("Placement name: \(String(describing: placementName)) has been loaded with height: \(height)")
        if let taboolaWidgetPlacement = taboolaWidgetPlacement {
            taboolaWidgetPlacement.frame = CGRect(x: 0, y: topText.frame.size.height, width: self.view.frame.size.width, height: taboolaWidgetPlacement.placementHeight)
            
            // Adding mid article widget to the ScrollView
            if taboolaWidgetPlacement.placementHeight > 0 && !didLoadWidget {
                loadMidText(taboolaWidgetPlacement: taboolaWidgetPlacement)
            }
            scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: topText.frame.size.height + taboolaWidgetPlacement.placementHeight + midText.frame.size.height)
        }
    }
    
    func classicUnit(_ classicUnit: UIView!, didFailToLoadPlacementName placementName: String!, errorMessage error: String!) {
        print(error as Any)
    }
    
    func classicUnit(_ classicUnit: UIView!, didClickPlacementName placementName: String!, itemId: String!, clickUrl: String!, isOrganic organic: Bool, customData: [AnyHashable : Any]!) -> Bool {
        return true
    }
}
