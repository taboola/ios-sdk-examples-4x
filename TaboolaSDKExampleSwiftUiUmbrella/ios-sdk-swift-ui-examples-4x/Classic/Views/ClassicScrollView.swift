//
//  ClassicScrollView.swift
//  TaboolaSwiftUI
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import SwiftUI
import TaboolaSDK_SwiftUI_Umbrella

struct ClassicScrollView: View {
    
    let title: String
    var taboolaPage = ClassicPageWrapper(pageType: Constants.article,
                                         pageUrl: Constants.pageUrl)
    var body: some View {
        ScrollView {
            LoremText()
            taboolaWidget(pageWrapper: taboolaPage)
            LoremText()
            taboolaFeed(pageWrapper: taboolaPage)
        }
        .navigationBarTitle(title, displayMode: .inline)
    }
}

struct ClassicScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ClassicScrollView(title: "ScrollView")
    }
}


struct taboolaFeed: View {
    
    let pageWrapper : ClassicPageWrapper
    
    @State var feedHeight: CGFloat = 0
    
    var body: some View {
            ClassicUnitSwiftUI(pageWrapper: pageWrapper,
                               placement: Constants.feedPlacement,
                               mode: Constants.mode,
                               height: $feedHeight).frame(height: feedHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct taboolaWidget: View {
    let pageWrapper : ClassicPageWrapper
    
    @State var topHeight: CGFloat = 0
    
    var body: some View {
            ClassicUnitSwiftUI(pageWrapper: pageWrapper,
                               placement: Constants.widgetPlacement,
                               mode: Constants.mode,
                               height: $topHeight).frame(height: topHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
    
}

