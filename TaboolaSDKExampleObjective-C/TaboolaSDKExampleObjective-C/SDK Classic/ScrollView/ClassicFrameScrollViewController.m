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
    self.view.frame = [UIScreen mainScreen].bounds;
    
    _topText = [[UILabel alloc] initWithFrame:self.view.bounds];
    [_scrollView addSubview:_topText];
    _topText.text = textToAdd;

    _topText.numberOfLines = 0;
    _topText.lineBreakMode = NSLineBreakByWordWrapping;
    
    [_topText sizeToFit];
    
    [self taboolaInit];
}

- (void)taboolaInit {
    _classicPage = [[TBLClassicPage alloc]initWithPageType:pageType pageUrl:pageUrl delegate:self scrollView:_scrollView];
    
    _taboolaFeedPlacement = [_classicPage createUnitWithPlacementName:placementFeedWithoutVideo mode:feedMode];
    [_taboolaFeedPlacement setFrame:CGRectMake(0, _topText.frame.size.height, self.view.frame.size.width, 200)];
    [_scrollView addSubview:_taboolaFeedPlacement];

    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, _taboolaFeedPlacement.placementHeight + _topText.frame.size.height);
    [self.view addSubview:_scrollView];
    
    [_taboolaFeedPlacement fetchContent];
}

- (void)dealloc {
    NSLog(@"Dealloc");
    [self.classicPage reset];
}

#pragma mark - TBLClassicPageDelegate

- (void)classicUnit:(UIView *)classicUnit didLoadOrResizePlacementName:(NSString *)placementName height:(CGFloat)height placementType:(PlacementType)placementType{
    NSLog(@"%@", placementName);

    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, _taboolaFeedPlacement.placementHeight + _topText.frame.size.height);
    [_taboolaFeedPlacement setFrame:CGRectMake(0, _topText.frame.size.height, self.view.frame.size.width, _taboolaFeedPlacement.placementHeight)];
}

- (void)classicUnit:(UIView *)classicUnit didFailToLoadPlacementName:(NSString *)placementName errorMessage:(NSString *)error{
    NSLog(@"%@", error);
}

- (BOOL)classicUnit:(UIView *)classicUnit didClickPlacementName:(NSString *)placementName itemId:(NSString *)itemId clickUrl:(NSString *)clickUrl isOrganic:(BOOL)organic customData: (NSDictionary *)customData {
    return YES;
}
@end
