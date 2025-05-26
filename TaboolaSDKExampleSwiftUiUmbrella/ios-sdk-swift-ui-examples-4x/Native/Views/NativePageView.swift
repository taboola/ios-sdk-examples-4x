//
//  NativePageView.swift
//  QAApp
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import SwiftUI

struct NativePageView<ViewModel: NativeViewModelProtocol>: View {

    let title: String
    let viewModels: [ViewModel]
    
    var body: some View {
        TabView {
            ForEach(0..<3) { index in
                NativeLazyVStack(title: title, viewModel: viewModels[index])
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .navigationBarTitle(title, displayMode: .inline)
        .tabViewStyle(.page)
    }
}

struct NativePageView_Previews: PreviewProvider {
    
    private static let factory = NativeViewModelFactory()
    
    static var previews: some View {
        NativePageView(title: "NativePageView",
                       viewModels: [factory.viewModel,
                                    factory.viewModel,
                                    factory.viewModel])
    }
}
