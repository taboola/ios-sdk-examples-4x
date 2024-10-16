//
//  ClassicCollectionViewManagedByPublisherController.swift
//  TaboolaSDKExampleV4
//
//  Copyright © 2020 Taboola. All rights reserved.
//

import UIKit
import TaboolaSDK

class ClassicCollectionViewManagedByPublisherController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // TBLClassicPage holds Taboola Widgets/Feed for a specific view
    
    var classicPage: TBLClassicPage?
    
    // TBLClassicUnit object represnting Widget/Feed
    var taboolaWidgetPlacement: TBLClassicUnit?
    var taboolaFeedPlacement: TBLClassicUnit?

    fileprivate let taboolaCellIdentifier = "TaboolaCollectionViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
 
        classicPage = TBLClassicPage.init(pageType: Constants.pageTypeArticle, pageUrl: Constants.pageUrl, delegate: self, scrollView: self.collectionView)
        
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

extension ClassicCollectionViewManagedByPublisherController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case Constants.taboolaWidgetSection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: taboolaCellIdentifier, for: indexPath)
            clearTaboolaInReusedCell(cell: cell)
            if let taboolaWidgetPlacement = taboolaWidgetPlacement {
                cell.addSubview(taboolaWidgetPlacement)
            }
            return cell
        case Constants.taboolaFeedSection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: taboolaCellIdentifier, for: indexPath)
            clearTaboolaInReusedCell(cell: cell)
            if let taboolaFeedPlacement = taboolaFeedPlacement {
                cell.addSubview(taboolaFeedPlacement)
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.randomCellIdentifier, for: indexPath)
            cell.backgroundColor = UIColor.random()
            return cell
        }
    }
    
    func clearTaboolaInReusedCell(cell: UICollectionViewCell) {
        for view in cell.subviews {
            view.removeFromSuperview()
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.totalSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case Constants.taboolaWidgetSection:
            return CGSize(width: self.view.frame.size.width, height: taboolaWidgetPlacement?.placementHeight ?? 200)
        case Constants.taboolaFeedSection:
            return CGSize(width: self.view.frame.size.width, height: taboolaFeedPlacement?.placementHeight ?? 200)
        default:
            return CGSize(width: self.view.frame.size.width, height: 200)
        }
    }
}

extension ClassicCollectionViewManagedByPublisherController: TBLClassicPageDelegate {
    func classicUnit(_ classicUnit: UIView!, didLoadOrResizePlacementName placementName: String!, height: CGFloat, placementType: PlacementType) {
        print("Placement name: \(String(describing: placementName)) has been loaded with height: \(height)")
        if placementName == Constants.placementBelowArticle {
            taboolaWidgetPlacement?.frame = CGRect(x: 0,y: 0,width: self.view.frame.size.width,height: taboolaWidgetPlacement?.placementHeight ?? 200)
        }
        else {
            taboolaFeedPlacement?.frame = CGRect(x: taboolaFeedPlacement?.frame.origin.x ?? 0,y: taboolaFeedPlacement?.frame.origin.y ?? 0,width: self.view.frame.size.width,height: taboolaFeedPlacement?.placementHeight ?? 200)
        }
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func classicUnit(_ classicUnit: UIView!, didFailToLoadPlacementName placementName: String!, errorMessage error: String!) {
        print(error as Any)
    }
    
    func classicUnit(_ classicUnit: UIView!, didClickPlacementName placementName: String!, itemId: String!, clickUrl: String!, isOrganic organic: Bool, customData: [AnyHashable : Any]!) -> Bool {
        return true
    }
}
