//
//  AppDelegate.swift
//  TaboolaSDKExampleV4
//
//  Copyright © 2020 Taboola. All rights reserved.
//

import UIKit
import TaboolaSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Adding Taboola init to the whole application with the unique publisher-name "sdk-tester-demo"
        let publisherInfo = TBLPublisherInfo.init(publisherName: "sdk-tester-demo")

        // Adding Taboola api-key to the whole application with the unique publisher-name "sdk-tester-demo" , required only for SDK Native
        publisherInfo.apiKey = "30dfcf6b094361ccc367bbbef5973bdaa24dbcd6"
        Taboola.initWith(publisherInfo)
            
        return true
    }

}

