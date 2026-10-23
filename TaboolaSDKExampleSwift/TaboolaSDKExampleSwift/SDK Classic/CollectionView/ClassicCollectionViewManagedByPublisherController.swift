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

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // Flow layout keeps the item sizes it has cached when only its bounds change, so cells would stay at
        // the pre-rotation width. Invalidating alongside the transition asks for sizes once the new bounds are in place.
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.collectionView.collectionViewLayout.invalidateLayout()
        })
    }

}

extension ClassicCollectionViewManagedByPublisherController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case Constants.taboolaWidgetSection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: taboolaCellIdentifier, for: indexPath)
            attachTaboolaUnit(taboolaWidgetPlacement, to: cell)
            return cell
        case Constants.taboolaFeedSection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: taboolaCellIdentifier, for: indexPath)
            attachTaboolaUnit(taboolaFeedPlacement, to: cell)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.randomCellIdentifier, for: indexPath)
            cell.backgroundColor = UIColor.random()
            return cell
        }
    }
    
    func attachTaboolaUnit(_ unit: TBLClassicUnit?, to cell: UICollectionViewCell) {
        clearTaboolaInReusedCell(cell: cell)
        guard let unit = unit else { return }
        // The unit fills the cell and follows its size from here on, e.g. on rotation or when the placement resizes
        unit.frame = cell.contentView.bounds
        unit.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cell.contentView.addSubview(unit)
    }

    func clearTaboolaInReusedCell(cell: UICollectionViewCell) {
        for view in cell.contentView.subviews {
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
        // Items span the collection view, which is inset from the screen edges by the safe area in landscape
        let width = collectionView.bounds.size.width
        switch indexPath.section {
        case Constants.taboolaWidgetSection:
            return CGSize(width: width, height: taboolaWidgetPlacement?.placementHeight ?? 200)
        case Constants.taboolaFeedSection:
            return CGSize(width: width, height: taboolaFeedPlacement?.placementHeight ?? 200)
        default:
            return CGSize(width: width, height: 200)
        }
    }
}

extension ClassicCollectionViewManagedByPublisherController: TBLClassicPageDelegate {
    func classicUnit(_ classicUnit: UIView!, didLoadOrResizePlacementName placementName: String!, height: CGFloat, placementType: PlacementType) {
        print("Placement name: \(String(describing: placementName)) has been loaded with height: \(height)")
        // Item sizes are read from placementHeight; the unit follows its cell
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func classicUnit(_ classicUnit: UIView!, didFailToLoadPlacementName placementName: String!, errorMessage error: String!) {
        print(error as Any)
    }
    
    func classicUnit(_ classicUnit: UIView!, didClickPlacementName placementName: String!, itemId: String!, clickUrl: String!, isOrganic organic: Bool, customData: [AnyHashable : Any]!) -> Bool {
        return true
    }
}
