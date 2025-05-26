//
//  ClassicTabView.swift
//  TaboolaSwiftUI
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import SwiftUI

struct ClassicTabView: View {
    
    let title: String
    @State var selectedIndex = 0

    var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(0..<3) { _ in
                ClassicVStack(title: "\(selectedIndex)")
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("\(selectedIndex)")
                }
            }
        }
        .navigationBarTitle(title, displayMode: .inline)
    }
}

struct TabViewView_Previews: PreviewProvider {
    static var previews: some View {
        ClassicTabView(title: "TabView")
    }
}
