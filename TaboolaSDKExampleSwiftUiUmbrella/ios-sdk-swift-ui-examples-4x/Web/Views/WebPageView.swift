//
//  WebPageView.swift
//  QAApp
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import SwiftUI

struct WebPageView: View {
    
    let title: String
    
    private let pageWrapper = WebPageWrapper()
        
    var body: some View {
        TabView {
            ForEach(0..<3) {
                WebVStack(title: "\($0)", embeddedInContainer: true)
            }
        }
        .tabViewStyle(.page)
        .navigationBarTitle(title)
        .onAppear {
            let appearance = UIPageControl.appearance()
            appearance.currentPageIndicatorTintColor = .black
            appearance.pageIndicatorTintColor = .gray
        }
    }
}

struct WebPageView_Previews: PreviewProvider {
    static var previews: some View {
        WebPageView(title: "WebPageView")
    }
}
