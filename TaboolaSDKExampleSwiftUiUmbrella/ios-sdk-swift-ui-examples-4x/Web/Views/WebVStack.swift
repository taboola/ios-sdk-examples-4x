//
//  WebVStack.swift
//  QAApp
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import SwiftUI
import TaboolaSDK_SwiftUI_Umbrella

struct WebVStack: View {
    
    init(title: String, embeddedInContainer: Bool = false) {
        self.title = title
        self.embeddedInContainer = embeddedInContainer
    }
    
    private let title: String
    private let embeddedInContainer: Bool
    private let pageWrapper = WebPageWrapper()
        
    var body: some View {
        VStack {
            if let baseURL = URL(string: "https://cdn.taboola.com/mobile-sdk/init/") {
                WebUnitSwiftUI(pageWrapper: pageWrapper,
                               source: "SampleHTMLPage",
                               baseURL: baseURL)
                Button("Fetch All") {
                    pageWrapper.page.fetchAllUnitsContent()
                }
                
                if embeddedInContainer {
                    Spacer(minLength: 40)
                }
            } else {
                Text("No content to display. Please check your URL!")
            }
        }
        .navigationBarTitle(title)
    }
}

struct WebVStack_Previews: PreviewProvider {
    static var previews: some View {
        WebVStack(title: "WebVStack")
    }
}
