//
//  ClassicPageWrapper.swift
//  TaboolaSwiftUI
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import TaboolaSDK
import TaboolaSDK_SwiftUI_Umbrella

class ClassicPageWrapper: NSObject, TBLClassicPageDelegate, СlassicPageWrappable {
    
    var page: TBLClassicPage!
    @Weak var delegates: [Coordinator]
    
    let reusableViewsQueue = ReusableViewsQueue<String, TBLClassicUnit>()
    
    init(pageType: String, pageUrl: String) {
        super.init()

        page = TBLClassicPage(pageType: pageType, pageUrl: pageUrl, delegate: self, scrollView: nil)
        page.pageExtraProperties = ["disableScrollIntercept": NSNumber(value: true)]
    }
    
    // MARK: - TBLClassicPageDelegate
    
    func classicUnit(_ classicUnit: UIView!,
                     didLoadOrResizePlacementName placementName: String!,
                     height: CGFloat,
                     placementType: PlacementType) {
        let delegates = delegates.filter { placementName.contains($0.unit.placement) }
        delegates.forEach { $0.didLoadWithHeight(height: height) }
    }
    
    func classicUnit(_ classicUnit: UIView!,
                     didClickPlacementName placementName: String!,
                     itemId: String!,
                     clickUrl: String!,
                     isOrganic organic: Bool) -> Bool {
        return organic
    }
}

//    MARK: Explore More
extension ClassicPageWrapper: TBLClassicExploreMoreDelegate {
    func initExploreMore() { // Init once per screen
        page.initializeExploreMore(withPlacement: Constants.placementExploreMore,
                                   mode: Constants.thumbsFeedMode,
                                   delegate: self,
                                   customSegment: Constants.customSegment)
    }
    
    func showExploreMore() { // Call on desired action/event
        page.showExploreMore()
    }
    
    // MARK: - TBLClassicExploreMoreDelegate
    func exploreMoreDidLoad() {
        print("Explore More did load")
    }

    func exploreMoreDidOpen() {
        print("Explore More did open")
    }
    
    func exploreMoreDidClose() {
        print("Explore More did close")
    }
    
    func exploreMoreDidReceiveError(_ error: String!) {
        print("Explore More did receive error: \(error!)")
    }
}
