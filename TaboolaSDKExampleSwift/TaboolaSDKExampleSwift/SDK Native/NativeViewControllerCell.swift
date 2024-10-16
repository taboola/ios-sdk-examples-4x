//
//  NativeViewControllerCell.swift
//  TaboolaSDKExampleSwift
//
//  Copyright © 2020 Taboola. All rights reserved.
//

import UIKit
import TaboolaSDK

class NativeViewControllerCell: UICollectionViewCell {
    @IBOutlet weak var tbImageView: TBLImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: TBLDescriptionLabel!
    @IBOutlet weak var brandingLabel: TBLBrandingLabel!
    @IBOutlet weak var titleLabel: TBLTitleLabel!
    @IBOutlet weak var attributionButton: UIButton!

    override func prepareForReuse() { // call this in order to have a "fresh start" on each cell
        super.prepareForReuse()
        imageView.image = nil
        descriptionLabel.text = ""
        brandingLabel.text = ""
        titleLabel.text = ""
    }
}
