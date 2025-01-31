//
//  ClassicFrameMetaAdController.m
//  TaboolaSDKExampleObjective-C
//
//  Created by Sasa Jovanovic on 15.1.25..
//  Copyright © 2025 Liad Elidan. All rights reserved.
//

#import <TaboolaSDK/TaboolaSDK.h>
#import "ClassicFrameMetaAdController.h"
#import "Constants.h"

@interface ClassicFrameMetaAdController () <TBLClassicPageDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *topText;
@property (nonatomic, strong) UILabel *midText;

// TBLClassicPage holds Taboola Widgets/Feed for a specific view
@property (nonatomic, strong) TBLClassicPage *classicPage;
// TBLClassicUnit object representing Widget/Feed
@property (nonatomic, strong) TBLClassicUnit *taboolaWidgetPlacement;

@property (nonatomic, assign) CGRect screenSize;
@property (nonatomic, assign) BOOL didLoadWidget;

@end

@implementation ClassicFrameMetaAdController

- (instancetype)init {
    self = [super init];
    if (self) {
        _screenSize = [UIScreen mainScreen].bounds;
        _didLoadWidget = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.screenSize.size.width, self.screenSize.size.height)];
    
    self.topText = [[UILabel alloc] initWithFrame:self.screenSize];
    [self textCreator:self.topText];
    
    [self.scrollView addSubview:self.topText];
    
    // Creating the Taboola page object
    [self taboolaInit];
    
    [self.view addSubview:self.scrollView];
}

- (void)taboolaInit {
    self.classicPage = [[TBLClassicPage alloc] initWithPageType:pageType
                                                       pageUrl:pageUrl
                                                     delegate:self
                                                   scrollView:self.scrollView];
    
    // Creating Taboola object - Widget
    self.taboolaWidgetPlacement = [self.classicPage createUnitWithPlacementName:metaPlacement
                                                                        mode:metaWidgetMode_1x1];
    self.taboolaWidgetPlacement.extraProperties = @{@"audienceNetworkPlacementId": audienceNetworkPlacementId};
    
    if (self.taboolaWidgetPlacement) {
        // Creating the frame of the Widget
        self.taboolaWidgetPlacement.frame = CGRectMake(0, self.topText.frame.size.height, self.view.frame.size.width, 200);
        [self.scrollView addSubview:self.taboolaWidgetPlacement];
        
        // Fetching content to receive recommendations
        [self.taboolaWidgetPlacement fetchContentOnly];
        
        // Setting the contentSize of the scrollView to include: midText height and the Widget height
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.topText.frame.size.height + self.taboolaWidgetPlacement.placementHeight);
    }
}

- (void)textCreator:(UILabel *)labelToEdit {
    labelToEdit.text = textToAdd;
    labelToEdit.numberOfLines = 0;
    labelToEdit.lineBreakMode = NSLineBreakByWordWrapping;
    [labelToEdit sizeToFit];
}

- (void)loadMidText:(TBLClassicUnit *)taboolaWidgetPlacement {
    self.didLoadWidget = YES;
    self.midText = [[UILabel alloc] initWithFrame:CGRectMake(0, self.topText.frame.size.height + taboolaWidgetPlacement.placementHeight, self.screenSize.size.width, self.screenSize.size.height)];
    [self textCreator:self.midText];
    [self.scrollView addSubview:self.midText];
}

#pragma mark - TBLClassicPageDelegate

- (void)classicUnit:(UIView *)classicUnit didLoadOrResizePlacementName:(NSString *)placementName height:(CGFloat)height placementType:(PlacementType)placementType {
    NSLog(@"Placement name: %@ has been loaded with height: %f", placementName, height);
    
    if (self.taboolaWidgetPlacement) {
        self.taboolaWidgetPlacement.frame = CGRectMake(0, self.topText.frame.size.height, self.view.frame.size.width, self.taboolaWidgetPlacement.placementHeight);
        
        // Adding mid article widget to the ScrollView
        if (self.taboolaWidgetPlacement.placementHeight > 0 && !self.didLoadWidget) {
            [self loadMidText:self.taboolaWidgetPlacement];
        }
        
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.topText.frame.size.height + self.taboolaWidgetPlacement.placementHeight + self.midText.frame.size.height);
    }
}

- (void)classicUnit:(UIView *)classicUnit didFailToLoadPlacementName:(NSString *)placementName errorMessage:(NSString *)error {
    NSLog(@"%@", error);
}

- (BOOL)classicUnit:(UIView *)classicUnit didClickPlacementName:(NSString *)placementName itemId:(NSString *)itemId clickUrl:(NSString *)clickUrl isOrganic:(BOOL)organic customData:(NSDictionary *)customData {
    return YES;
}

@end
