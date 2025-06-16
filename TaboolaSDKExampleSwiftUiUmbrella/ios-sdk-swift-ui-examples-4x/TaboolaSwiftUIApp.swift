//
//  TaboolaSwiftUIApp.swift
//  TaboolaSwiftUI
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import SwiftUI
import TaboolaSDK

@main
struct TaboolaSwiftUIApp: App {
    
    private let factory = NativeViewModelFactory()
    
    init() {
        setupTaboola()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                VStack(spacing: 24) {
                    NavigationLink("Classic") {
                        ClassicRootView()
                    }
                    NavigationLink("Native") {
                        NativeRootView(factory: factory)
                    }
                    NavigationLink("Web") {
                        WebRootView()
                    }
                }
                .navigationTitle("SwiftUI Examples")
            }
            .navigationViewStyle(.stack)
        }
    }
}

extension TaboolaSwiftUIApp {
    func setupTaboola() {
        let publisherInfo = TBLPublisherInfo(publisherName: Constants.publisherName)
        publisherInfo.apiKey = Constants.apiKey
        Taboola.initWith(publisherInfo)
        Taboola.setLogLevel(.LogLevelDebug)
    }
}
