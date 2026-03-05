//
//  ClassicInterstitialController.m
//  TaboolaSDKExampleObjective-C
//
//  Copyright © 2020 Taboola. All rights reserved.
//

#import "ClassicInterstitialController.h"
#import <TaboolaSDK/TaboolaSDK.h>

@interface ClassicInterstitialController () <TBLClassicInterstitialDelegate>

@property (weak, nonatomic) IBOutlet UIButton *showButton;

@end

@implementation ClassicInterstitialController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Disable the show button until the interstitial is loaded
    [self.showButton setEnabled:NO];
    
    [self taboolaInit];
}

- (void)taboolaInit {
    // Initialize TBLClassicPage with page type, URL, delegate, and scroll view (nil for interstitial)
    _classicPage = [[TBLClassicPage alloc] initWithPageType:pageType
                                                     pageUrl:pageUrl
                                                    delegate:self 
                                                  scrollView:nil];
    
    // Initialize the interstitial with placement name and mode
    // The interstitial content will be fetched automatically
    [_classicPage initInterstitialWithPlacement:placementInterstitial
                                           mode:widgetMode_5050
                                       delegate:self
                                  customSegment:nil];
    
    [_classicPage loadInterstitial];
}

- (void)dealloc {
    NSLog(@"Dealloc");
    [self.classicPage reset];
}


- (IBAction)showButtonTapped:(UIButton *)button {
    [self.classicPage showInterstitial];
}

#pragma mark - TBLClassicPageDelegate

- (void)interstitialDidLoadAd {
    NSLog(@"✅ Interstitial loaded successfully");
    
    [self.showButton setEnabled:YES];
}

- (void)interstitialDidDismiss { 
    NSLog(@"Interstitial dismissed");
}


- (void)interstitialDidFailToLoadAdWithError:(NSString *)error { 
    NSLog(@"⚠️ Interstitial failed to load: %@", error);
    
    // Keep the button disabled since the ad didn't load
    [self.showButton setEnabled:NO];
}


- (void)interstitialDidPresent {
    NSLog(@"Interstitial presented");
}


- (void)interstitialDidReceiveTapEvent {
    NSLog(@"Interstitial received tap event");
}


- (void)interstitialWillDismiss {
    NSLog(@"Interstitial will dismiss");
}


- (void)interstitialWillPresent {
    NSLog(@"Interstitial will present");
}

@end
