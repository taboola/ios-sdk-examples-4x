//
//  NativeViewModelFactory.swift
//  QAApp
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import Foundation
import TaboolaSDK

protocol NativeViewModelFactoryProtocol {
    associatedtype ViewModel: NativeViewModelProtocol
    var viewModel: ViewModel { get }
}

struct NativeViewModelFactory: NativeViewModelFactoryProtocol {

    var viewModel: some NativeViewModelProtocol {
        NativeViewModel(placement: Constants.nativePlacement,
                        sourceType: SourceTypeText,
                        pageUrl: Constants.pageUrl,
                        batchSize: 5)
    }
}
