//
//  NativeLazyVStack.swift
//  QAApp
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import SwiftUI
import TaboolaSDK_SwiftUI_Umbrella

struct NativeLazyVStack<ViewModel: NativeViewModelProtocol>: View {
    
    let title: String
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.items) { item in
                        NativeUnitSwiftUI<NativeContentView>(item, targetWidth: geometry.size.width)
                            .onAppear {
                                viewModel.onAppear(item)
                            }
                    }
                }
            }
            .navigationBarTitle(title, displayMode: .inline)
            .onAppear {
                viewModel.fetchContent()
            }
        }
    }
}

struct NativeLazyVStackView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            NativeLazyVStack(title: "NativeLazyVStack",
                             viewModel: NativeViewModelFactory().viewModel)
        }
    }
}
