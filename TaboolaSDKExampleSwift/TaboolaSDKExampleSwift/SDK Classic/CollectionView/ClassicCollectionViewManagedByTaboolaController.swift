//
//  ClassicCollectionViewManagedByTaboolaController.swift
//  TaboolaSDKExampleV4
//
//  Copyright © 2020 Taboola. All rights reserved.
//

import UIKit
import TaboolaSDK

class ClassicCollectionViewManagedByTaboolaController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // TBLClassicPage holds Taboola Widgets/Feed for a specific view
    var classicPage: TBLClassicPage?
    // TBLClassicUnit object represnting Widget/Feed
    var taboolaWidgetPlacement: TBLClassicUnit?
    var taboolaFeedPlacement: TBLClassicUnit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        classicPage = TBLClassicPage.init(pageType: Constants.pageTypeArticle, pageUrl: Constants.pageUrl, delegate: self, scrollView: self.collectionView)
        classicPage?.pageExtraProperties = ["key":"true"] // example for pageExtraProperties
        
        taboolaWidgetPlacement = classicPage?.createUnit(withPlacementName: Constants.placementBelowArticle, mode: Constants.widgetMode_1x4)
        
        if let taboolaWidgetPlacement = taboolaWidgetPlacement {
            taboolaWidgetPlacement.fetchContent()
        }
        
        taboolaFeedPlacement = classicPage?.createUnit(withPlacementName: Constants.placementFeedWithoutVideo, mode: Constants.thumbsFeedMode)

        if let taboolaFeedPlacement = taboolaFeedPlacement {
            taboolaFeedPlacement.fetchContent()
        }
    }
}

extension ClassicCollectionViewManagedByTaboolaController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case Constants.taboolaWidgetSection:
            if let taboolaWidgetPlacement = taboolaWidgetPlacement {
                // get a cell managed by Taboola SDK
                let cell = taboolaWidgetPlacement.collectionView(collectionView, cellForItemAt: indexPath, withBackground: UIColor.red)
                return cell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.randomCellIdentifier, for: indexPath)
            cell.backgroundColor = UIColor.random()
            return cell
        case Constants.taboolaFeedSection:
            if let taboolaFeedPlacement = taboolaFeedPlacement {
                // get a cell managed by Taboola SDK
                let cell = taboolaFeedPlacement.collectionView(collectionView, cellForItemAt: indexPath, withBackground: nil)
                return cell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.randomCellIdentifier, for: indexPath)
            cell.backgroundColor = UIColor.random()
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.randomCellIdentifier, for: indexPath)
            cell.backgroundColor = UIColor.random()
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.totalSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var widgetSize = CGSize(width: self.view.frame.size.width, height: 200)

        if indexPath.section == Constants.taboolaWidgetSection {
            if let taboolaSize = taboolaWidgetPlacement?.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: indexPath, withUIInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)) {
                    widgetSize = taboolaSize
            }
        }
        else if indexPath.section == Constants.taboolaFeedSection {
            if let taboolaSize = taboolaFeedPlacement?.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: indexPath, withUIInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)) {
                    widgetSize = taboolaSize
                }
        }
        return widgetSize
    }
}

extension ClassicCollectionViewManagedByTaboolaController: TBLClassicPageDelegate {
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
