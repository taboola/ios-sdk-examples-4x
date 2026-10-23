//
//  ClassicScrollViewController.m
//  TaboolaSDKExampleObjective-C
//
//  Copyright © 2020 Taboola. All rights reserved.
//

#import "ClassicFrameScrollViewController.h"
#import <TaboolaSDK/TaboolaSDK.h>
#import "RandomColor.h"

@interface ClassicFrameScrollViewController () <TBLClassicPageDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *topText;
@property (nonatomic, strong) UILabel* midText;

// TBLClassicPage holds Taboola Widgets/Feed for a specific view
@property (nonatomic, strong) TBLClassicPage* classicPage;
// TBLClassicUnit object represnting Widget/Feed
@property (nonatomic, strong) TBLClassicUnit* taboolaWidgetPlacement;
@property (nonatomic, strong) TBLClassicUnit* taboolaFeedPlacement;

@end

@implementation ClassicFrameScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _topText = [[UILabel alloc] init];
    [_scrollView addSubview:_topText];
    _topText.text = textToAdd;

    _topText.numberOfLines = 0;
    _topText.lineBreakMode = NSLineBreakByWordWrapping;
    
    [self taboolaInit];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // Frames don't follow the scroll view on their own, so they are laid out again when its width changes, e.g. on rotation
    if (_topText.frame.size.width != _scrollView.bounds.size.width) {
        [self layoutContentWithFeedHeight:_taboolaFeedPlacement.frame.size.height];
    }
}

- (void)taboolaInit {
    _classicPage = [[TBLClassicPage alloc]initWithPageType:pageType pageUrl:pageUrl delegate:self scrollView:_scrollView];
    
    _taboolaFeedPlacement = [_classicPage createUnitWithPlacementName:placementFeedWithoutVideo mode:feedMode];
    [_scrollView addSubview:_taboolaFeedPlacement];
    [self layoutContentWithFeedHeight:200];

    [_taboolaFeedPlacement fetchContent];
}

- (void)layoutContentWithFeedHeight:(CGFloat)feedHeight {
    // Content is sized to the scroll view, which is inset from the screen edges by the safe area in landscape
    CGFloat width = _scrollView.bounds.size.width;
    CGFloat textHeight = [_topText sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)].height;
    _topText.frame = CGRectMake(0, 0, width, textHeight);

    [_taboolaFeedPlacement setFrame:CGRectMake(0, _topText.frame.size.height, width, feedHeight)];
    _scrollView.contentSize = CGSizeMake(width, feedHeight + _topText.frame.size.height);
}

- (void)dealloc {
    NSLog(@"Dealloc");
    [self.classicPage reset];
}

#pragma mark - TBLClassicPageDelegate

- (void)classicUnit:(UIView *)classicUnit didLoadOrResizePlacementName:(NSString *)placementName height:(CGFloat)height placementType:(PlacementType)placementType{
    NSLog(@"%@", placementName);

    [self layoutContentWithFeedHeight:_taboolaFeedPlacement.placementHeight];
}

- (void)classicUnit:(UIView *)classicUnit didFailToLoadPlacementName:(NSString *)placementName errorMessage:(NSString *)error{
    NSLog(@"%@", error);
}

- (BOOL)classicUnit:(UIView *)classicUnit didClickPlacementName:(NSString *)placementName itemId:(NSString *)itemId clickUrl:(NSString *)clickUrl isOrganic:(BOOL)organic customData: (NSDictionary *)customData {
    return YES;
}
@end
