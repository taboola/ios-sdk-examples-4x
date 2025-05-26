//
//  ClassicList.swift
//  TaboolaSwiftUI
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import SwiftUI
import TaboolaSDK_SwiftUI_Umbrella

struct ClassicList: View {
    
    let title: String
    let pageWrapper = ClassicPageWrapper(pageType: Constants.article,
                                         pageUrl: Constants.pageUrl)
    
    @State var topHeight: CGFloat = 0
    @State var feedHeight: CGFloat = 0
    
    var body: some View {
        List {
            LoremText()
            ClassicUnitSwiftUI(pageWrapper: pageWrapper,
                               placement: Constants.widgetPlacement,
                               mode: Constants.mode,
                               height: $topHeight).frame(height: topHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            LoremText()
            ClassicUnitSwiftUI(pageWrapper: pageWrapper,
                               placement: Constants.feedPlacement,
                               mode: Constants.mode,
                               height: $feedHeight).frame(height: feedHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        .navigationBarTitle(title, displayMode: .inline)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ClassicList(title: "List")
    }
}
