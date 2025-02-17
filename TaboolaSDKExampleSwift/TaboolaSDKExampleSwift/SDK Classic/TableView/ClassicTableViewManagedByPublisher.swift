//
//  ClassicTableViewManagedByPublisher.swift
//  TaboolaSDKExampleV4
//
//  Copyright © 2020 Taboola. All rights reserved.
//

import UIKit
import TaboolaSDK

class ClassicTableViewManagedByPublisherController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // TBLClassicPage holds Taboola Widgets/Feed for a specific view
    var classicPage: TBLClassicPage?
    // TBLClassicUnit object represnting Widget/Feed
    var taboolaWidgetPlacement: TBLClassicUnit?
    var taboolaFeedPlacement: TBLClassicUnit?

    fileprivate let taboolaCellIdentifier = "TaboolaTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        taboolaInit()
    }
    
    func taboolaInit() {
        classicPage = TBLClassicPage.init(pageType: Constants.pageTypeArticle, pageUrl: Constants.pageUrl, delegate: self, scrollView: self.tableView)
        
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

extension ClassicTableViewManagedByPublisherController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case Constants.taboolaWidgetSection:
            let cell = tableView.dequeueReusableCell(withIdentifier: taboolaCellIdentifier, for: indexPath)
            clearTaboolaInReusedCell(cell: cell)
            if let taboolaWidgetPlacement = taboolaWidgetPlacement {
                cell.contentView.addSubview(taboolaWidgetPlacement)
            }
            return cell
        case Constants.taboolaFeedSection:
            let cell = tableView.dequeueReusableCell(withIdentifier: taboolaCellIdentifier, for: indexPath)
            clearTaboolaInReusedCell(cell: cell)
            if let taboolaFeedPlacement = taboolaFeedPlacement {
                cell.contentView.addSubview(taboolaFeedPlacement)
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.randomCellIdentifier, for: indexPath)
            cell.backgroundColor = UIColor.random()
            return cell
        }
    }
    
    func clearTaboolaInReusedCell(cell :UITableViewCell) {
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.totalSections
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case Constants.taboolaWidgetSection:
            return taboolaWidgetPlacement?.placementHeight ?? 200
        case Constants.taboolaFeedSection:
            return taboolaFeedPlacement?.placementHeight ?? 200
        default:
            return 200
        }
    }
}

extension ClassicTableViewManagedByPublisherController: TBLClassicPageDelegate {
    func classicUnit(_ classicUnit: UIView!, didLoadOrResizePlacementName placementName: String!, height: CGFloat, placementType: PlacementType) {
        print("Placement name: \(String(describing: placementName)) has been loaded with height: \(height)")
        if placementName == Constants.placementBelowArticle {
            taboolaWidgetPlacement?.frame = CGRect(x: 0,y: 0,width: self.view.frame.size.width,height: taboolaWidgetPlacement?.placementHeight ?? 200)
        }
        else {
            taboolaFeedPlacement?.frame = CGRect(x: taboolaFeedPlacement?.frame.origin.x ?? 0,y: taboolaFeedPlacement?.frame.origin.y ?? 0,width: self.view.frame.size.width,height: taboolaFeedPlacement?.placementHeight ?? 200)
        }
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    func classicUnit(_ classicUnit: UIView!, didFailToLoadPlacementName placementName: String!, errorMessage error: String!) {
        print(error as Any)
    }
    
    func classicUnit(_ classicUnit: UIView!, didClickPlacementName placementName: String!, itemId: String!, clickUrl: String!, isOrganic organic: Bool, customData: [AnyHashable : Any]!) -> Bool {
        return true
    }
}
