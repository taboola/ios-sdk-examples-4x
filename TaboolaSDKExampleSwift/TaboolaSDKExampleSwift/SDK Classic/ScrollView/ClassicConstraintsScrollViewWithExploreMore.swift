//
//  ClassicConstraintsScrollViewWithExploreMore.swift
//  TaboolaSDKExampleSwift
//
//  Created by Sasa Jovanovic on 26. 9. 2025..
//  Copyright © 2025 Taboola. All rights reserved.
//

import UIKit
import TaboolaSDK

class ClassicConstraintsScrollViewWithExploreMore: ClassicConstraintsScrollViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        classicPage?.initExploreMore(withPlacement: Constants.placementExploreMore,
                                     mode: Constants.thumbsFeedMode,
                                     delegate: self,
                                     customSegment: Constants.customSegment)
    }
    
    @objc private func triggerExploreMore() {
        classicPage?.showExploreMore()
    }
    
    private func setupBackButton() {
        let customButton = UIButton(type: .system)
        customButton.setTitle("Explore More", for: .normal)
        customButton.addTarget(self, action: #selector(triggerExploreMore), for: .touchUpInside)

        let barButton = UIBarButtonItem(customView: customButton)
        self.navigationItem.rightBarButtonItem = barButton
    }
}

// MARK: - Explore More delegate

extension ClassicConstraintsScrollViewWithExploreMore: TBLClassicExploreMoreDelegate {
    func exploreMoreDidOpen() {
        print("Explore More did open")
    }
    
    func exploreMoreDidClose() {
        print("Explore More did close")
    }
    
    func exploreMoreDidReceiveError(_ error: String!) {
        print("Explore More did receive an error: \(error!)")
    }
}
