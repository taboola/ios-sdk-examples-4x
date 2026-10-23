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

// The page and unit must stay alive until the fetch completes: the SDK only holds them weakly
@property (nonatomic, strong) TBLNativePage* nativePage;
@property (nonatomic, strong) TBLNativeUnit* taboolaUnit;

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
    _nativePage = [[TBLNativePage alloc]initWithDelegate:self sourceType:SourceTypeText pageUrl:@"http://www.example.com"];

    _taboolaUnit = [_nativePage createUnitWithPlacement:@"Below Article" numberOfItems:1];

    __weak typeof(self) weakSelf = self;
    [_taboolaUnit fetchContentOnSuccess:^(TBLRecommendationResponse *response) {
        if (response.items.count > 0) {
            TBLNativeItem *item1 = response.items[0];
            if (item1 != nil) {
                [item1 initThumbnailView:weakSelf.imageView];
                [item1 initTitleView:weakSelf.titleView];
                [item1 initBrandingView:weakSelf.brandingView];
                [item1 initThumbnailView:weakSelf.imageView completed:^(NSError *error, UIImage *image) {
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
