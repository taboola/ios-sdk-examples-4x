//
//  Constants.swift
//  TaboolaSDKExampleSwift
//
//  Copyright © 2020 Taboola. All rights reserved.
//

import UIKit

struct Constants {
    // Section for the Taboola Widget presentation
    static let taboolaWidgetSection = 6
    // Section for the Taboola Feed presentation
    static let taboolaFeedSection = 35
    static let totalSections = 36
    static let totalRowsNative = 10
    static let totalSectionsNative = 1
    static let pageTypeArticle = "article"
    // Placement name to be used for the Taboola Widget
    static let placementBelowArticle = "Below Article"
    static let placementFeedWithoutVideo = "Feed without video"
    static let placementAboveArticle = "Above Article"
    static let placementLimitedFeed = "Limited Feed"
    static let widgetMode_1x1 = "alternating-widget-without-video-1x1"
    static let widgetMode_1x4 = "alternating-widget-without-video-1x4"
    static let widgetMode_1x8 = "widget-with-8-cards";
    static let thumbsFeedMode = "thumbs-feed-01"
    static let pageUrl = "http://www.example.com"
    static let nativeCell = "NativeViewControllerCell"
    static let randomCellIdentifier = "RandomCell"


    static let textToAdd = "Interdum et malesuada fames ac ante ipsum! \n\nCum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aliquam lacus lorem, tristique vel molestie sed, laoreet in felis. Pellentesque consectetur massa libero, in bibendum nisl euismod ultricies. Vestibulum eros neque, venenatis id luctus id, ornare eu lorem. Duis elementum neque ut erat elementum fermentum eget ege Interdum et malesuada fames ac ante ipsum! \n\nCum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aliquam lacus lorem, tristique vel molestie sed, laoreet in felis. Pellentesque consectetur massa libero, in bibendum nisl euismod ultricies. Vestibulum eros neque, venenatis id luctus id, ornare eu lorem. Duis elementum neque ut erat elementum fermentum eget ege Interdum et malesuada fames ac ante ipsum! \n\nCum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aliquam lacus lorem, tristique vel molestie sed, laoreet in felis. Pellentesque consectetur massa libero, in bibendum nisl euismod ultricies. Vestibulum eros neque, venenatis id luctus id, ornare eu lorem. Duis elementum neque ut erat elementum fermentum eget ege Interdum et malesuada fames ac ante ipsum! \n\nCum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aliquam lacus lorem, tristique vel molestie sed, laoreet in felis. Pellentesque consectetur massa libero, in bibendum nisl euismod ultricies. Vestibulum eros neque, venenatis id luctus id, ornare eu lorem. Duis elementum neque ut erat elementum fermentum eget ege"
    static let nativeText = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem"
    
}

extension UIColor {
    static func random() -> UIColor {
        UIColor(red: .random(in: 0...1),
                green: .random(in: 0...1),
                blue: .random(in: 0...1),
                alpha: 1.0)
    }
}
