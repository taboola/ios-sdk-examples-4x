//
//  ClassicConstraintsScrollViewController.h
//  TaboolaSDKExampleObjective-C
//
//  Copyright © 2020 Taboola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import <TaboolaSDK/TaboolaSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClassicConstraintsScrollViewController : UIViewController
// TBLClassicPage holds Taboola Widgets/Feed for a specific view
@property (nonatomic, strong) TBLClassicPage* classicPage;
@end

NS_ASSUME_NONNULL_END
