//
//  NativeLazyVGrid.swift
//  QAApp
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import SwiftUI
import TaboolaSDK_SwiftUI_Umbrella

struct NativeLazyVGrid<ViewModel: NativeViewModelProtocol>: View {
    
    let title: String
    @StateObject var viewModel: ViewModel
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(viewModel.items) { item in
                        NativeUnitSwiftUI<NativeContentView>(item, targetWidth: geometry.size.width / 2)
                            .onAppear {
                                viewModel.onAppear(item)
                            }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitle(title, displayMode: .inline)
        .onAppear {
            viewModel.fetchContent()
        }
    }
}

struct NativeLazyVGrid_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            NativeLazyVGrid(title: "NativeLazyVGrid",
                            viewModel: NativeViewModelFactory().viewModel)
        }
    }
}
