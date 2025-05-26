//
//  NativeContentView.swift
//  QAApp
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import SwiftUI
import TaboolaSDK
import TaboolaSDK_SwiftUI_Umbrella

final class NativeContentView: UIView, NativeViewable {
    
    private enum Constant {
        static let offset: CGFloat = 8
        static let imageRatio: CGFloat = 0.5
    }
    
    private var contentSize: CGSize = .zero {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
            
    // MARK: - Outlets
    
    private(set) lazy var titleLabel: TBLTitleLabel = {
        let titleLabel = TBLTitleLabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    private(set) lazy var imageView: TBLImageView = {
        let imageView = TBLImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private(set) lazy var brandingLabel: TBLBrandingLabel = {
        let brandingLabel = TBLBrandingLabel()
        brandingLabel.translatesAutoresizingMaskIntoConstraints = false
        brandingLabel.setContentHuggingPriority(.required, for: .vertical)
        return brandingLabel
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupUI()
    }
    
    override var intrinsicContentSize: CGSize {
        contentSize
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateLayout(targetWidth width: CGFloat) {
        // Explictly set `preferredMaxLayoutWidth` to calculate title label height accurately.
        titleLabel.preferredMaxLayoutWidth = width - Constant.offset * 2

        let targetSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        contentSize = systemLayoutSizeFitting(targetSize,
                                              withHorizontalFittingPriority: .required,
                                              verticalFittingPriority: .fittingSizeLevel)
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.offset).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.offset).isActive = true
        
        addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.offset).isActive = true
        imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: Constant.imageRatio).isActive = true
        imageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true

        addSubview(brandingLabel)

        brandingLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constant.offset).isActive = true
        brandingLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        brandingLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        brandingLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
