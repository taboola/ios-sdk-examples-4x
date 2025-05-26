//
//  NativeRootView.swift
//  QAApp
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import SwiftUI

struct NativeRootView<ViewModelFactory: NativeViewModelFactoryProtocol>: View {
        
    private let factory: ViewModelFactory
    
    init(factory: ViewModelFactory) {
        self.factory = factory
    }
    
    var body: some View {
        VStack(spacing: 24) {
            NavigationLink(destination: NativeLazyVStack(title: "LazyVStack",
                                                         viewModel: factory.viewModel)) {
                Text("LazyVStack")
            }
            NavigationLink(destination: NativeLazyVGrid(title: "LazyVGrid",
                                                            viewModel: factory.viewModel)) {
                Text("LazyGridView")
            }
            NavigationLink(destination: NativePageView(title: "PageView",
                                                       viewModels: [factory.viewModel,
                                                                    factory.viewModel,
                                                                    factory.viewModel])) {
                Text("PageView")
            }
            NavigationLink(destination: NativeTabView(title: "TabView",
                                                      viewModels: [factory.viewModel,
                                                                   factory.viewModel,
                                                                   factory.viewModel])) {
                Text("TabView")
            }
        }
        .navigationBarTitle("Native", displayMode: .inline)
    }
}

struct NativeViews_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            NativeRootView(factory: NativeViewModelFactory())
        }
    }
}
