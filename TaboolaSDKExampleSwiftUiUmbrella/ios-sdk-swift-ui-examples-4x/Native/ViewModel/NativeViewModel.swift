//
//  NativeViewModel.swift
//  QAApp
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import Foundation
import TaboolaSDK

protocol NativeViewModelProtocol: ObservableObject {
    var items: [TBLNativeItem] { get }
    
    func fetchContent()
    func onAppear(_ item: TBLNativeItem)
}

class NativeViewModel: NSObject {
        
    private enum State {
        case idle
        case fetching
        case loaded
        case failed
        
        var shouldLoad: Bool {
            self == .idle || self == .failed
        }
    }
    
    private var state: State = .idle {
        didSet {
            if state == .idle {
                fetchContent()
            }
        }
    }
    
    private let batchSize: Int32
    
    private var page: TBLNativePage?
    private var unit: TBLNativeUnit?
    
    @Published var items: [TBLNativeItem] = []
    
    init(placement: String, sourceType: SourceType, pageUrl: String, batchSize: Int32) {
        self.batchSize = batchSize

        super.init()
        
        page = TBLNativePage(delegate: self, sourceType: sourceType, pageUrl: pageUrl)
        unit = page?.createUnit(withPlacement: placement, numberOfItems: batchSize)
    }
}

extension NativeViewModel: NativeViewModelProtocol {
    
    func onAppear(_ item: TBLNativeItem) {
        let shouldLoadMore = items.firstIndex(of: item) == items.count - 1
        if shouldLoadMore {
            state = .idle
        }
    }
    
    func fetchContent() {
        guard let unit = unit, state.shouldLoad else { return }
    
        state = .fetching
        unit.fetchContent { [weak self] response in
            guard let self = self,
                  let items = response?.items as? [TBLNativeItem],
                    items.count > 0 else { return }
            self.state = .loaded
            self.items.append(contentsOf: items)
        } onFailure: { [weak self] error in
            guard let self = self else { return }
            self.state = .idle
            print(error.debugDescription)
        }
    }
}

extension NativeViewModel: TBLNativePageDelegate {
    
    func onItemClick(_ placementName: String,
                     withItemId itemId: String,
                     withClickUrl clickUrl: String,
                     isOrganic organic: Bool,
                     customData: String) -> Bool {
        true
    }
}
