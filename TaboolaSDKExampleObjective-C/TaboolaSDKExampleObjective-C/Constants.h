//
//  Constants.h
//  TaboolaSDKExampleObjective-C
//
//  Copyright © 2020 Taboola. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, Constants) {
    // Section for the Taboola Widget presentation
    taboolaWidgetSection = 6,
    // Section for the Taboola Feed presentation
    taboolaFeedSection = 12,
    totalSections = 13,
    totalRowsNative = 10,
    totalSectionsNative = 1
};

// Placement name to be used for the Taboola Widget
static NSString * const placementBelowArticle       = @"Below Article";
static NSString * const placementFeedWithoutVideo   = @"Feed without video";
static NSString * const placementLimitedFeed        = @"Limited Feed";
static NSString * const aboveArticePlacement        = @"Above Article";
static NSString * const pageType                    = @"article";
static NSString * const pageUrl                     = @"http://www.example.com";
static NSString * const feedMode                    = @"thumbs-feed-01";
static NSString * const widgetMode_1x1              = @"alternating-widget-without-video-1x1";
static NSString * const widgetMode_1x4              = @"alternating-widget-without-video-1x4";
static NSString * const widgetMode_1x8              = @"widget-with-8-cards";

// Meta params

static NSString * const publisherId = @"sdk-tester-meta";
static NSString * const audienceNetworkApplicationId = @"783094497262888";
static NSString * const audienceNetworkPlacementId = @"783094497262888_864779472427723";
// Placements
static NSString * const metaPlacement = @"Below Article Thumbnails";

// Modes
static NSString * const metaWidgetMode_1x1 = @"meta-widget-1x1";
static NSString * const metaFeedMode = @"alternating-thumbnails-a";

static NSString * const textToAdd                   = @"Interdum et malesuada fames ac ante ipsum! \n\nCum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aliquam lacus lorem, tristique vel molestie sed, laoreet in felis. Pellentesque consectetur massa libero, in bibendum nisl euismod ultricies. Vestibulum eros neque, venenatis id luctus id, ornare eu lorem. Duis elementum neque ut erat elementum fermentum eget ege Interdum et malesuada fames ac ante ipsum! \n\nCum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aliquam lacus lorem, tristique vel molestie sed, laoreet in felis. Pellentesque consectetur massa libero, in bibendum nisl euismod ultricies. Vestibulum eros neque, venenatis id luctus id, ornare eu lorem. Duis elementum neque ut erat elementum fermentum eget ege Interdum et malesuada fames ac ante ipsum! \n\nCum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aliquam lacus lorem, tristique vel molestie sed, laoreet in felis. Pellentesque consectetur massa libero, in bibendum nisl euismod ultricies. Vestibulum eros neque, venenatis id luctus id, ornare eu lorem. Duis elementum neque ut erat elementum fermentum eget ege Interdum et malesuada fames ac ante ipsum! \n\nCum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aliquam lacus lorem, tristique vel molestie sed, laoreet in felis. Pellentesque consectetur massa libero, in bibendum nisl euismod ultricies. Vestibulum eros neque, venenatis id luctus id, ornare eu lorem. Duis elementum neque ut erat elementum fermentum eget ege";

static NSString* const nativeText                   = @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem";

static NSString * const randomCell                  = @"RandomCell";
static NSString * const taboolaCollectionCell       = @"TaboolaCollectionViewCell";
static NSString * const taboolaTableCell            = @"TaboolaTableViewCell";



NS_ASSUME_NONNULL_END

