//
//  WebRootView.swift
//  QAApp
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import SwiftUI

struct WebRootView: View {
    
    var body: some View {
        VStack(spacing: 24) {
            NavigationLink(destination: WebVStack(title: "VStack")) {
                Text("VStack")
            }
            NavigationLink(destination: WebPageView(title: "PageView")) {
                Text("PageView")
            }
        }
        .navigationBarTitle("Web", displayMode: .inline)
    }
}

struct WebRootView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WebRootView()
        }
    }
}
