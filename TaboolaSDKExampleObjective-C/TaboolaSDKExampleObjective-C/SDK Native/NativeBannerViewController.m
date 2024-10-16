//
//  NativeBannerViewController.m
//  TaboolaSDKExampleObjective-C
//
//  Copyright © 2020 Taboola. All rights reserved.
//

#import "NativeBannerViewController.h"
#import <TaboolaSDK/TaboolaSDK.h>
#import "RandomColor.h"


@interface NativeBannerViewController () <TBLNativePageDelegate,UITableViewDataSource>

// TBLNativeItem object that will hold taboola native recommendations
@property (nonatomic, strong) TBLNativeItem* taboolaItem;

// Multiple Taboola objects for Image/Description/Branding/Title
@property (weak, nonatomic) IBOutlet TBLImageView *imageView;
@property (weak, nonatomic) IBOutlet TBLDescriptionLabel *descriptionView;
@property (weak, nonatomic) IBOutlet TBLBrandingLabel *brandingView;
@property (weak, nonatomic) IBOutlet TBLTitleLabel *titleView;

@end

@implementation NativeBannerViewController

#pragma mark - ViewController lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self taboolaInit];
}

- (void)taboolaInit {
    TBLNativePage *nativePage = [[TBLNativePage alloc]initWithDelegate:self sourceType:SourceTypeText pageUrl:@"http://www.example.com"];
    
    TBLNativeUnit *taboolaUnit = [nativePage createUnitWithPlacement:@"Below Article" numberOfItems:1];
    
    [taboolaUnit fetchContentOnSuccess:^(TBLRecommendationResponse *response) {
        if (response.items.count > 0) {
            TBLNativeItem *item1 = response.items[0];
            if (item1 != nil) {
                [item1 initThumbnailView:self.imageView];
                [item1 initTitleView:self.titleView];
                [item1 initBrandingView:self.brandingView];
                [item1 initThumbnailView:self.imageView completed:^(NSError *error, UIImage *image) {
                    if (error) {
                        NSLog(@"error: %@",error.description);
                    }
                }];
            }
        }
    } onFailure:^(NSError *error) {
        if (error) {
            NSLog(@"error: %@",error.description);
        }
    }];
}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return totalRowsNative;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextCell" forIndexPath:indexPath];
    cell.textLabel.text = nativeText;
    return cell;
}

#pragma mark - TBLNativePageDelegate

- (BOOL)onItemClick:(NSString *)placemetName withItemId:(NSString *)itemId withClickUrl:(NSString *)clickUrl isOrganic:(BOOL)organic customData:(nonnull NSString *)customData {
    return YES;
}

@end
