//
//  AppDelegate.m
//  TaboolaSDKExampleObjective-C
//
//  Copyright © 2020 Taboola. All rights reserved.
//

#import "AppDelegate.h"
#import <TaboolaSDK/TaboolaSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Adding Taboola init to the whole application with the unique publisher-name "sdk-tester-demo"
    TBLPublisherInfo *publisherInfo = [[TBLPublisherInfo alloc] initWithPublisherName:@"sdk-tester-demo"];
    // Adding Taboola api-key to the whole application with the unique publisher-name "sdk-tester-demo" , required only for SDK Native
    publisherInfo.apiKey = @"30dfcf6b094361ccc367bbbef5973bdaa24dbcd6";
    
    [Taboola initWithPublisherInfo:publisherInfo];
    
    return YES;
}

@end
