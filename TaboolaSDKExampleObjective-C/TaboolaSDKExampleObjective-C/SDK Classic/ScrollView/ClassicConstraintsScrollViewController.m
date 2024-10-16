//
//  ClassicConstraintsScrollViewController.m
//  TaboolaSDKExampleObjective-C
//
//  Copyright © 2020 Taboola. All rights reserved.
//

#import "ClassicConstraintsScrollViewController.h"
#import <TaboolaSDK/TaboolaSDK.h>
#import "RandomColor.h"

@interface ClassicConstraintsScrollViewController () <TBLClassicPageDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *top;
@property (weak, nonatomic) IBOutlet UIView *bottom;

// TBLClassicPage holds Taboola Widgets/Feed for a specific view
@property (nonatomic, strong) TBLClassicPage* classicPage;
// TBLClassicUnit object represnting Widget/Feed
@property (nonatomic, strong) TBLClassicUnit* taboolaWidgetPlacement;
@property (nonatomic, strong) TBLClassicUnit* taboolaFeedPlacement;

@end

@implementation ClassicConstraintsScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self taboolaInit];
}

- (void)taboolaInit {
    _classicPage = [[TBLClassicPage alloc]initWithPageType:pageType pageUrl:pageUrl delegate:self scrollView:_scrollView];
    
    _taboolaWidgetPlacement = [_classicPage createUnitWithPlacementName:aboveArticePlacement mode:widgetMode_1x1];
    
    _taboolaFeedPlacement = [_classicPage createUnitWithPlacementName:placementFeedWithoutVideo mode:feedMode];
    _taboolaFeedPlacement.clipsToBounds = YES;

    [_taboolaWidgetPlacement fetchContent];
    [_taboolaFeedPlacement fetchContent];
    
    [self setTaboolaConstraintsToSuper];
}

- (void)setTaboolaConstraintsToSuper {
    [_top addSubview:_taboolaWidgetPlacement];
    _taboolaWidgetPlacement.translatesAutoresizingMaskIntoConstraints = NO;
    [_taboolaWidgetPlacement.topAnchor constraintEqualToAnchor:_top.topAnchor constant:0].active = YES;
    [_taboolaWidgetPlacement.bottomAnchor constraintEqualToAnchor:_top.bottomAnchor constant:0].active = YES;
    [_taboolaWidgetPlacement.leadingAnchor constraintEqualToAnchor:_top.leadingAnchor constant:0].active = YES;
    [_taboolaWidgetPlacement.trailingAnchor constraintEqualToAnchor:_top.trailingAnchor constant:0].active = YES;
    
    [_bottom addSubview:_taboolaFeedPlacement];
    _taboolaFeedPlacement.translatesAutoresizingMaskIntoConstraints = NO;
    [_taboolaFeedPlacement.topAnchor constraintEqualToAnchor:_bottom.topAnchor constant:0].active = YES;
    [_taboolaFeedPlacement.bottomAnchor constraintEqualToAnchor:_bottom.bottomAnchor constant:0].active = YES;
    [_taboolaFeedPlacement.leadingAnchor constraintEqualToAnchor:_bottom.leadingAnchor constant:0].active = YES;
    [_taboolaFeedPlacement.trailingAnchor constraintEqualToAnchor:_bottom.trailingAnchor constant:0].active = YES;
}

- (void)dealloc {
    NSLog(@"Dealloc");
    [self.classicPage reset];
}

#pragma mark - TBLClassicPageDelegate

- (void)classicUnit:(UIView *)classicUnit didLoadOrResizePlacementName:(NSString *)placementName height:(CGFloat)height placementType:(PlacementType)placementType{
    NSLog(@"%@", placementName);
}

- (void)classicUnit:(UIView *)classicUnit didFailToLoadPlacementName:(NSString *)placementName errorMessage:(NSString *)error{
    NSLog(@"%@", error);
}

- (BOOL)classicUnit:(UIView *)classicUnit didClickPlacementName:(NSString *)placementName itemId:(NSString *)itemId clickUrl:(NSString *)clickUrl isOrganic:(BOOL)organic customData: (NSDictionary *)customData {
    return YES;
}

@end
