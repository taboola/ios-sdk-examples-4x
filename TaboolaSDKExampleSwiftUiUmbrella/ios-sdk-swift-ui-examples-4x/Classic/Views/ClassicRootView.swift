//
//  ClassicRootView.swift
//  TaboolaSwiftUI
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import SwiftUI
import TaboolaSDK_SwiftUI_Umbrella

struct ClassicRootView: View {
    var body: some View {
        VStack(spacing: 24) {
            NavigationLink(destination: LazyView(ClassicScrollView(title: "ScrollView"))) {
                Text("ScrollView")
            }
            NavigationLink(destination: LazyView(ClassicVStack(title: "VStack"))) {
                Text("VStack")
            }
            NavigationLink(destination: LazyView(ClassicList(title: "List"))) {
                Text("List")
            }
            NavigationLink(destination: LazyView(ClassicTabView(title: "TabView"))) {
                Text("TabView")
            }
            NavigationLink(destination: LazyView(ClassicLazyVGrid(title: "LazyVGrid"))) {
                Text("LazyVGrid")
            }
            NavigationLink(destination: LazyView(ClassicLazyVStack(title: "LazyVStack"))) {
                Text("LazyVStack")
            }
            // SwiftUI has known issue with orientation changes - https://www.hackingwithswift.com/forums/swiftui/pagetabviewstyle-does-not-play-nicely-on-orientation/10813.
            NavigationLink(destination: LazyView(ClassicPageView(title: "PageView"))) {
                Text("PageView")
            }
        }
        .navigationBarTitle("Classic", displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ClassicRootView()
    }
}
