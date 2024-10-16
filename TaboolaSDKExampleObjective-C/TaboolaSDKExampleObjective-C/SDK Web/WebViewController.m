//
//  WebViewController.m
//  TaboolaSDKExampleObjective-C
//
//  Copyright © 2020 Taboola. All rights reserved.
//

#import "WebViewController.h"
#import <TaboolaSDK/TaboolaSDK.h>
#import <WebKit/WebKit.h>


@interface WebViewController () <WKNavigationDelegate, TBLWebPageDelegate>

@property (weak, nonatomic) IBOutlet UIView *webViewContainer;

@property (nonatomic, strong) WKWebView *webView;

// The TBLWebPage object that will contain the Taboola content fetched via JS
@property (nonatomic, strong) TBLWebPage* webPage;
@property (nonatomic, strong) TBLWebUnit *webUnit;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
    
    _webView.frame = self.view.frame;
    [_webViewContainer addSubview:_webView];
    
    _webPage = [[TBLWebPage alloc]initWithDelegate:self];
    _webUnit = [_webPage createUnitWithWebView:_webView];
    
    [self loadExamplePage:_webView];
}

- (void)loadExamplePage:(WKWebView*)webView {
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"SampleHTMLPage" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [webView loadHTMLString:appHtml baseURL:[NSURL URLWithString:@"https://cdn.taboola.com/mobile-sdk/init/"]];	
}

- (void)webView:(UIView *)webView didLoadPlacementNamed:(NSString *)placementName withHeight:(CGFloat)height {
    NSLog(@"%@", placementName);
}

- (void)taboolaView:(UIView *)taboolaView didFailToLoadPlacementNamed:(NSString *)placementName withErrorMessage:(NSString *)error {
    NSLog(@"%@", error);
}

- (BOOL)webView:(WKWebView *)webView didClickPlacementName:(NSString *)placementName
         itemId:(NSString *)itemId
       clickUrl:(NSString *)clickUrl
      isOrganic:(BOOL)organic
     customData:(NSDictionary *)customData {
    // Return 'YES' for Taboola SDK to handle the click event (default behavior).
    // Return 'NO' to handle the click event yourself. (Applicable for organic content only (including Audience Exchange items).)
    
    // You can identify Audience Exchange items by checking the customData dictionary
    // Note that you will also need to pass in an Extra Property flag called allowAudienceExchangeClickOverride with the value of true
    if (customData[@"isAudienceExchange"] && [customData[@"isAudienceExchange"] boolValue]) {
        // Handle Audience Exchange items
        return NO;
    }
    
    return YES;
}

@end
