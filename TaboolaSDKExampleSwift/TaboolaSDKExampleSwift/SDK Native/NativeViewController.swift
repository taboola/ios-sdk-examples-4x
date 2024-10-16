//
//  NativeViewController.swift
//  TaboolaSDKExampleV4
//
//  Copyright © 2020 Taboola. All rights reserved.
//

import Foundation
import TaboolaSDK

class NativeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var nativePage: TBLNativePage?
    var taboolaUnit: TBLNativeUnit?
    var itemsArray: NSMutableArray? // itemsArray object that will hold taboola native recommendations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsArray = NSMutableArray()
        self.collectionView.register(UINib(nibName: Constants.nativeCell, bundle: nil), forCellWithReuseIdentifier: Constants.nativeCell)
        taboolaInit()
    }
    
    func taboolaInit() {
        nativePage =  TBLNativePage.init(delegate: self, sourceType: SourceTypeText, pageUrl: Constants.pageUrl)
        taboolaUnit = nativePage?.createUnit(withPlacement: Constants.widgetMode_1x4, numberOfItems: 5)

        taboolaUnit?.fetchContent(onSuccess: {[weak self] (response) in
            self?.itemsArray = response?.items
            self?.collectionView.reloadData()
        }) { (error) in
            print(error.debugDescription)
        }
    }
    
    func fetchNextPage() {
        weak var weakSelf = self
        taboolaUnit?.fetchContent(onSuccess: { (response) in
            if let response = response {
                guard let newItems = response.items else {
                    print("An error occured with response.items")
                    return
                }
                // call performBatchUpdates in order to insert the new items to the collection's data
                weakSelf?.collectionView.performBatchUpdates({
                    guard let resultsSize = weakSelf?.itemsArray?.count else { return }
                    weakSelf?.itemsArray?.addObjects(from: newItems as [AnyObject])
                    let arrayWithIndexPaths = NSMutableArray()
                    for i in resultsSize..<(resultsSize + newItems.count) {
                        arrayWithIndexPaths.add(NSIndexPath(row: i, section: 0))
                    }
                    weakSelf?.collectionView.insertItems(at: arrayWithIndexPaths as! [IndexPath])
                }, completion: nil)
            }
        }, onFailure: { (error) in
            print(error.debugDescription)
        })
    }
}

extension NativeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.totalSectionsNative
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let itemsArray = itemsArray else {
            print("An error occured with itemsArray")
            return 0
        }
        return itemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = UIScreen.main.bounds.size.width
        if let interfaceOrientation = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.windowScene?.interfaceOrientation {
            if interfaceOrientation == .landscapeLeft || interfaceOrientation == .landscapeRight {
                width = UIScreen.main.bounds.size.height
            }
        }
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.nativeCell, for: indexPath)
        if let cell = cell as? NativeViewControllerCell {
            cell.attributionButton.addTarget(self, action: #selector(clickedTaboolaAttribution), for: .touchDown)
            guard let itemsArray = itemsArray else { return UICollectionViewCell() }
            if let item = itemsArray[indexPath.row] as? TBLNativeItem {
                item.initThumbnailView(cell.tbImageView)
                item.initTitleView(cell.titleLabel)
                item.initBrandingView(cell.brandingLabel)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let itemsArray = itemsArray else {
            print("An error occured with itemsArray")
            return
        }
        // when reach to the end of collectionView fetch more items
        if indexPath.row == itemsArray.count - 1 {
            self.fetchNextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // when clicking an item an internal delegate is called and opens the article
    }
    
    @objc func clickedTaboolaAttribution() {
        nativePage?.handleAttributionClick()
    }
}

extension NativeViewController: TBLNativePageDelegate {
    func taboolaView(_ taboolaView: UIView!, didLoadOrResizePlacement placementName: String!, withHeight height: CGFloat, placementType: PlacementType) {
        print("Placement name: \(String(describing: placementName)) has been loaded with height: \(height)")
    }
    
    func taboolaView(_ taboolaView: UIView!, didFailToLoadPlacementNamed placementName: String!, withErrorMessage error: String!) {
        print(error.debugDescription)
    }
    
    func onItemClick(_ placementName: String, withItemId itemId: String, withClickUrl clickUrl: String, isOrganic organic: Bool, customData: String) -> Bool {
        return true
    }
}
