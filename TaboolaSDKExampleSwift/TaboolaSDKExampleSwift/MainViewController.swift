//
//  MainViewController.swift
//  TaboolaSDKExampleV4
//
//  Copyright © 2020 Taboola. All rights reserved.
//

import UIKit
import AppTrackingTransparency
import TaboolaSDK

class MainViewController: UIViewController {
    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        initDefaultPublisher()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestTrackingAuthorization()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Actions
    @IBAction func didTapCLassicMetaIntegration(_ sender: UIButton) {
        initMetaPublisher()
        initializeClassicMainScrollController(isForMetaAds: true)
    }
    
    // MARK: - Private functions
    private func initDefaultPublisher() {
        let publisherInfo = TBLPublisherInfo.init(publisherName: "sdk-tester-demo")
        publisherInfo.apiKey = "30dfcf6b094361ccc367bbbef5973bdaa24dbcd6"
        Taboola.initWith(publisherInfo)
        Taboola.setGlobalExtraProperties(["audienceNetworkApplicationId":""])
    }
    
    private func initMetaPublisher() {
        let publisherInfo = TBLPublisherInfo.init(publisherName: "sdk-tester-meta")
        Taboola.initWith(publisherInfo)
        // Set global extra properties for getting Meta ads
        // audienceNetworkApplicationId required
        // enableMetaDemandDebug optional for getting Meta ads in debug mode
        Taboola.setGlobalExtraProperties(["audienceNetworkApplicationId":Constants.audienceNetworkApplicationId,
                                          "enableMetaDemandDebug":"true"])
    }
    
    private func initializeClassicMainScrollController(isForMetaAds:Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ClassicMainScrollViewController") as? ClassicMainScrollViewController
        navigationController?.pushViewController(viewController!, animated: true)
        viewController?.isForMetaAds = isForMetaAds
    }
    
    // MARK: - Apple tracking request
    private func requestTrackingAuthorization() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    print("Tracking authorized")
                case .denied:
                    print("Tracking denied")
                case .restricted:
                    print("Tracking restricted")
                case .notDetermined:
                    print("Tracking status not determined")
                @unknown default:
                    print("Unknown tracking status")
                }
            }
        } else {
            print("Tracking not available on iOS versions below 14")
        }
    }
}
