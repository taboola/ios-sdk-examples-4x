//
//  NativeTabView.swift
//  QAApp
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import SwiftUI

struct NativeTabView<ViewModel: NativeViewModelProtocol>: View {
    
    let title: String
    let viewModels: [ViewModel]
    @State var selectedIndex = 0

    var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(0..<3, id: \.self) { index in
                NavigationView {
                    NativeLazyVStack(title: "\(selectedIndex)", viewModel: viewModels[index])
                }
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("\(index)")
                }
            }
        }
    }
}

struct NativeTabView_Previews: PreviewProvider {
    
    private static let factory = NativeViewModelFactory()

    static var previews: some View {
        NativeTabView(title: "NativeTabView",
                      viewModels: [factory.viewModel,
                                   factory.viewModel,
                                   factory.viewModel])
    }
}
