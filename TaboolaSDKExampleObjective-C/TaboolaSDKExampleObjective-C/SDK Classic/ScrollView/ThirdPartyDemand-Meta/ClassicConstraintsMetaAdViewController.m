//
//  ClassicConstraintsMetaAdViewController.m
//  TaboolaSDKExampleObjective-C
//
//  Created by Sasa Jovanovic on 15.1.25..
//  Copyright © 2025 Liad Elidan. All rights reserved.
//
#import <TaboolaSDK/TaboolaSDK.h>
#import "ClassicConstraintsMetaAdViewController.h"
#import "Constants.h"

@interface ClassicConstraintsMetaAdViewController() <TBLClassicPageDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *widgetHolder;

@property (nonatomic, strong) TBLClassicPage *classicPage;
@property (nonatomic, strong) TBLClassicUnit *taboolaWidgetPlacement;
@property (nonatomic, strong) TBLClassicUnit *taboolaFeedPlacement;

@end

@implementation ClassicConstraintsMetaAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize Taboola
    [self taboolaInit];
    
    // Set the background color
    self.view.backgroundColor = [UIColor systemBackgroundColor];
}

- (void)taboolaInit {
    // Initialize the Taboola page object
    self.classicPage = [[TBLClassicPage alloc] initWithPageType:pageType
                                                     pageUrl:pageUrl
                                                   delegate:self
                                                 scrollView:self.scrollView];
    
    // Create the Taboola widget placement
    self.taboolaWidgetPlacement = [self.classicPage createUnitWithPlacementName:metaPlacement
                                                                        mode:metaWidgetMode_1x1];
    
    // Set additional properties for the widget
    self.taboolaWidgetPlacement.extraProperties = @{ @"audienceNetworkPlacementId": audienceNetworkPlacementId };
    
    // Fetch the content for the widget
    if (self.taboolaWidgetPlacement) {
        [self.taboolaWidgetPlacement fetchContentOnly];
    }
    
    // Set constraints for the Taboola widget
    [self setTaboolaConstraintsToSuper];
}

- (void)setTaboolaConstraintsToSuper {
    if (self.taboolaWidgetPlacement) {
        [self.widgetHolder addSubview:self.taboolaWidgetPlacement];
        self.taboolaWidgetPlacement.translatesAutoresizingMaskIntoConstraints = NO;
        
        // Set constraints for the Taboola widget placement
        [NSLayoutConstraint activateConstraints:@[
            [self.taboolaWidgetPlacement.topAnchor constraintEqualToAnchor:self.widgetHolder.topAnchor],
            [self.taboolaWidgetPlacement.bottomAnchor constraintEqualToAnchor:self.widgetHolder.bottomAnchor],
            [self.taboolaWidgetPlacement.leadingAnchor constraintEqualToAnchor:self.widgetHolder.leadingAnchor],
            [self.taboolaWidgetPlacement.trailingAnchor constraintEqualToAnchor:self.widgetHolder.trailingAnchor]
        ]];
    }
}

#pragma mark - TBLClassicPageDelegate

- (void)classicUnit:(UIView *)classicUnit didLoadOrResizePlacementName:(NSString *)placementName height:(CGFloat)height placementType:(PlacementType)placementType {
    NSLog(@"Placement name: %@ has been loaded with height: %f", placementName, height);
}

- (void)classicUnit:(UIView *)classicUnit didFailToLoadPlacementName:(NSString *)placementName errorMessage:(NSString *)error {
    NSLog(@"%@", error);
}

- (BOOL)classicUnit:(UIView *)classicUnit didClickPlacementName:(NSString *)placementName itemId:(NSString *)itemId clickUrl:(NSString *)clickUrl isOrganic:(BOOL)isOrganic customData:(NSDictionary<NSString *, id> *)customData {
    return YES;
}

@end
