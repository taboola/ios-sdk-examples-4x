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

    var didLoadWidget: Bool = false
    var didLoadFeed: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        // Content is laid out against the scroll view, which is inset from the screen edges by the safe area in landscape
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        textCreator(labeToEdit: topText)
        scrollView.addSubview(topText)

        // Creating the Taboola page object
        taboolaInit()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Frames don't follow the scroll view on their own, so they are laid out again when its width changes, e.g. on rotation
        if topText.frame.size.width != scrollView.bounds.size.width {
            layoutContent()
        }
    }

    func taboolaInit() {
        classicPage = TBLClassicPage.init(pageType: Constants.pageTypeArticle, pageUrl: Constants.pageUrl, delegate: self, scrollView: self.scrollView)

        // Creating the first Taboola object - Widget
        taboolaWidgetPlacement = classicPage?.createUnit(withPlacementName: Constants.placementBelowArticle, mode: Constants.widgetMode_1x4)

        if let taboolaWidgetPlacement = taboolaWidgetPlacement {
            self.scrollView.addSubview(taboolaWidgetPlacement)

            // Fetching content to recieve recommendations
            taboolaWidgetPlacement.fetchContent()

            // Creating the second Taboola object - Feed
            taboolaFeedPlacement = classicPage?.createUnit(withPlacementName: Constants.placementFeedWithoutVideo, mode: Constants.thumbsFeedMode)
            taboolaFeedPlacement?.fetchContent()
        }
        layoutContent()
    }

    /// Stacks top text, widget, mid text and feed vertically at the scroll view's width
    func layoutContent() {
        let width = scrollView.bounds.size.width
        func place(_ view: UIView, at y: CGFloat, height: CGFloat) -> CGFloat {
            view.frame = CGRect(x: 0, y: y, width: width, height: height)
            return view.frame.maxY
        }
        func textHeight(_ label: UILabel) -> CGFloat {
            return label.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude)).height
        }

        var y = place(topText, at: 0, height: textHeight(topText))
        if let taboolaWidgetPlacement = taboolaWidgetPlacement {
            // The widget gets a fixed height to load into until it reports its own
            y = place(taboolaWidgetPlacement, at: y, height: didLoadWidget ? taboolaWidgetPlacement.placementHeight : 200)
        }
        if didLoadWidget {
            y = place(midText, at: y, height: textHeight(midText))
        }
        if didLoadFeed, let taboolaFeedPlacement = taboolaFeedPlacement {
            y = place(taboolaFeedPlacement, at: y, height: taboolaFeedPlacement.placementHeight)
        }
        scrollView.contentSize = CGSize(width: width, height: y)
    }

    func textCreator(labeToEdit: UILabel) {
        labeToEdit.text = Constants.textToAdd
        labeToEdit.numberOfLines = 0
        labeToEdit.lineBreakMode = NSLineBreakMode.byWordWrapping
    }

    func loadMidText() {
        didLoadWidget = true
        textCreator(labeToEdit: midText)
        scrollView.addSubview(midText)
    }
}

extension ClassicFrameScrollViewController: TBLClassicPageDelegate {
    func classicUnit(_ classicUnit: UIView!, didLoadOrResizePlacementName placementName: String!, height: CGFloat, placementType: PlacementType) {
        print("Placement name: \(String(describing: placementName)) has been loaded with height: \(height)")
        if placementName == Constants.placementBelowArticle {
            // Adding mid article text to the ScrollView once the widget has content
            if let taboolaWidgetPlacement = taboolaWidgetPlacement, taboolaWidgetPlacement.placementHeight > 0 && !didLoadWidget {
                loadMidText()
            }
        } else if let taboolaFeedPlacement = taboolaFeedPlacement, !didLoadFeed {
            didLoadFeed = true
            scrollView.addSubview(taboolaFeedPlacement)
        }
        layoutContent()
    }

    func classicUnit(_ classicUnit: UIView!, didFailToLoadPlacementName placementName: String!, errorMessage error: String!) {
        print(error as Any)
    }

    func classicUnit(_ classicUnit: UIView!, didClickPlacementName placementName: String!, itemId: String!, clickUrl: String!, isOrganic organic: Bool, customData: [AnyHashable : Any]!) -> Bool {
        return true
    }
}
