//
//  MainViewController.m
//  TaboolaSDKExampleObjective-C
//
//  Copyright © 2020 Taboola. All rights reserved.
//
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <TaboolaSDK/TaboolaSDK.h>
#import "MainViewController.h"
#import "ClassicMainScrollViewController.h"
#import "Constants.h"

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self initDefaultPublisher];
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self requestTrackingAuthorization];
}

// MARK: - Actions
- (IBAction)didTapClassicMetaIntegration:(UIButton *)sender {
    [self initMetaPublisher];
    [self initializeClassicMainScrollControllerForAdType:YES];
}

// MARK: - Private functions
- (void)initDefaultPublisher {
    TBLPublisherInfo *publisherInfo = [[TBLPublisherInfo alloc] initWithPublisherName:@"sdk-tester-demo"];
    publisherInfo.apiKey = @"30dfcf6b094361ccc367bbbef5973bdaa24dbcd6";
    [Taboola initWithPublisherInfo:publisherInfo];
    [Taboola setGlobalExtraProperties:@{@"audienceNetworkApplicationId": @""}];
}

- (void)initMetaPublisher {
    TBLPublisherInfo *publisherInfo = [[TBLPublisherInfo alloc] initWithPublisherName:@"sdk-tester-meta"];
    [Taboola initWithPublisherInfo:publisherInfo];
    // Set global extra properties for getting meta ads
    // audienceNetworkApplicationId required
    // enableMetaDemandDebug optional for getting meta ads in debug mode
    [Taboola setGlobalExtraProperties:@{@"audienceNetworkApplicationId": audienceNetworkApplicationId,
                                        @"enableMetaDemandDebug": @"true"}];
}

- (void)initializeClassicMainScrollControllerForAdType:(BOOL)isForMetaAds {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ClassicMainScrollViewController"];
    
    if ([viewController isKindOfClass:[ClassicMainScrollViewController class]]) {
        ClassicMainScrollViewController *classicController = (ClassicMainScrollViewController *)viewController;
        classicController.isForMetaAds = isForMetaAds;
        [self.navigationController pushViewController:classicController animated:YES];
    }
}

// MARK: - Apple tracking request
- (void)requestTrackingAuthorization {
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            switch (status) {
                case ATTrackingManagerAuthorizationStatusAuthorized:
                    NSLog(@"Tracking authorized");
                    break;
                case ATTrackingManagerAuthorizationStatusDenied:
                    NSLog(@"Tracking denied");
                    break;
                case ATTrackingManagerAuthorizationStatusRestricted:
                    NSLog(@"Tracking restricted");
                    break;
                case ATTrackingManagerAuthorizationStatusNotDetermined:
                    NSLog(@"Tracking status not determined");
                    break;
                default:
                    NSLog(@"Unknown tracking status");
                    break;
            }
        }];
    } else {
        NSLog(@"Tracking not available on iOS versions below 14");
    }
}

@end
