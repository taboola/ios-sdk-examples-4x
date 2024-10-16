//
//  ClassicTableViewController.swift
//  TaboolaSDKExampleV4
//
//  Copyright © 2020 Taboola. All rights reserved.
//

import UIKit
import TaboolaSDK

class ClassicTableViewManagedByTaboolaController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
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

extension ClassicTableViewManagedByTaboolaController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case Constants.taboolaWidgetSection:
            if let taboolaWidgetPlacement = taboolaWidgetPlacement {
                let cell = taboolaWidgetPlacement.tableView(tableView, cellForRowAt: indexPath, withBackground: nil)
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.randomCellIdentifier, for: indexPath)
            cell.backgroundColor = UIColor.random()
            return cell
        case Constants.taboolaFeedSection:
            if let taboolaFeedPlacement = taboolaFeedPlacement {
                let cell = taboolaFeedPlacement.tableView(tableView, cellForRowAt: indexPath, withBackground: nil)
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.randomCellIdentifier, for: indexPath)
            cell.backgroundColor = UIColor.random()
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.randomCellIdentifier, for: indexPath)
            cell.backgroundColor = UIColor.random()
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.totalSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var widgetHeight = CGFloat(200.0)

        if indexPath.section == Constants.taboolaWidgetSection {
            if let taboolaHeight = taboolaWidgetPlacement?.tableView(tableView, heightForRowAt: indexPath, withUIInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)) {
                widgetHeight = taboolaHeight
            }
        }
        if indexPath.section == Constants.taboolaFeedSection {
            if let taboolaHeight = taboolaFeedPlacement?.tableView(tableView, heightForRowAt: indexPath, withUIInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)) {
                widgetHeight = taboolaHeight
            }
        }
        return widgetHeight
    }
}

extension ClassicTableViewManagedByTaboolaController: TBLClassicPageDelegate {
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

