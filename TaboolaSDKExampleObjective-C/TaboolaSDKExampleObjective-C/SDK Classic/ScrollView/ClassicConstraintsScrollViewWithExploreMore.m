//
//  ClassicConstraintsScrollViewWithExploreMore.m
//  TaboolaSDKExampleObjective-C
//
//  Created by Sasa Jovanovic on 29. 9. 2025..
//  Copyright © 2025 Taboola. All rights reserved.

#import "ClassicConstraintsScrollViewWithExploreMore.h"
#import "Constants.h"

@implementation ClassicConstraintsScrollViewWithExploreMore

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupButton];
    [self.classicPage initExploreMoreWithPlacement:placementExploreMore
                                              mode:feedMode
                                          delegate:self
                                     customSegment:customSegment];
}

- (void)triggerExploreMore {
    [self.classicPage showExploreMore];
}

- (void)setupButton {
    UIButton *exploreMoreButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [exploreMoreButton setTitle:@"Explore More" forState:UIControlStateNormal];
    
    [exploreMoreButton addTarget:self
                     action:@selector(triggerExploreMore)
           forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:exploreMoreButton];
    self.navigationItem.rightBarButtonItem = barButton;
}

#pragma mark - Explore More delegate

- (void)exploreMoreDidOpen {
    NSLog(@"Explore More did open");
}

- (void)exploreMoreDidClose {
    NSLog(@"Explore More did close");
}

- (void)exploreMoreDidReceiveError:(NSString *)error {
    NSLog(@"Explore More did receive an error: %@", error);
}

@end
