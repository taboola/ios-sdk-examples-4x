//
//  ClassicPageView.swift
//  TaboolaSwiftUI
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import SwiftUI

struct ClassicPageView: View {
    
    let title: String
    let colors: [Color] = [.red, .green, .yellow, .blue]
    
    var body: some View {
        TabView {
            ForEach(0..<4) {
                ClassicScrollView(title: title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(colors[$0 % colors.count])
                    .cornerRadius(8)
            }
        }
        .navigationBarTitle(title, displayMode: .inline)
        .tabViewStyle(.page)
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        ClassicPageView(title: "PageView")
    }
}
