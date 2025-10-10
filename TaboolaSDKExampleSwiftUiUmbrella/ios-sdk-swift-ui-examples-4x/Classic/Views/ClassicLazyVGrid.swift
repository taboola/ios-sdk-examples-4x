//
//  ClassicLazyVGrid.swift
//  TaboolaSwiftUI
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import SwiftUI
import TaboolaSDK_SwiftUI_Umbrella

struct ClassicLazyVGrid: View {

    let colors: [Color] = [.red, .green, .yellow, .blue]
    var columns: [GridItem] = Array(repeating: .init(.flexible(), alignment: .center), count: 1)
    let title: String
    let pageWrapper = ClassicPageWrapper(pageType: Constants.article,
                                         pageUrl: Constants.pageUrl)
    
    @State var topHeight: CGFloat = 0
    @State var feedHeight: CGFloat = 0

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0...2, id: \.self) { index in
                    switch index {
                    case 0:
                        ClassicUnitSwiftUI(pageWrapper: pageWrapper,
                                           placement: Constants.placementAboveArticle,
                                           mode: Constants.widgetMode_1x4,
                                           height: $topHeight).frame(height:topHeight)
                            .background(colors[index % colors.count])
                            .cornerRadius(8)
                    case 1:
                        Text("Cell \(index)")
                            .frame(width: 110, height: 500)
                            .background(colors[index % colors.count])
                            .cornerRadius(8)
                    default:
                        ClassicUnitSwiftUI(pageWrapper: pageWrapper,
                                           placement: Constants.placementFeedWithoutVideo,
                                           mode: Constants.thumbsFeedMode,
                                           height: $feedHeight).frame(height:feedHeight)
                            .background(colors[index % colors.count])
                            .cornerRadius(8)
                    }
                }
            }
        }
    }
}

struct LazyVGridView_Previews: PreviewProvider {
    static var previews: some View {
        ClassicLazyVGrid(title: "LazyVGrid")
    }
}
