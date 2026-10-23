//
//  ClassicCollectionViewManagedByTaboolaController.m
//  TaboolaSDKExampleObjective-C
//
//  Copyright © 2020 Taboola. All rights reserved.
//

#import "ClassicCollectionViewManagedByTaboolaController.h"
#import <TaboolaSDK/TaboolaSDK.h>
#import "RandomColor.h"

@interface ClassicCollectionViewManagedByTaboolaController () <TBLClassicPageDelegate>

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewManagedByTaboola;

// TBLClassicPage holds Taboola Widgets/Feed for a specific view
@property (nonatomic, strong) TBLClassicPage *classicPage;
// TBLClassicUnit object representing Widget/Feed
@property (nonatomic, strong) TBLClassicUnit *taboolaWidgetPlacement;
@property (nonatomic, strong) TBLClassicUnit *taboolaFeedPlacement;

@end

@implementation ClassicCollectionViewManagedByTaboolaController

#pragma mark - ViewController lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self taboolaInit];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    // Flow layout keeps the item sizes it has cached when only its bounds change, so cells would stay at
    // the pre-rotation width. Invalidating alongside the transition asks for sizes once the new bounds are in place.
    __weak typeof(self) weakSelf = self;
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [weakSelf.collectionViewManagedByTaboola.collectionViewLayout invalidateLayout];
    } completion:nil];
}

- (void)taboolaInit {
    _classicPage = [[TBLClassicPage alloc]initWithPageType:pageType pageUrl:pageUrl delegate:self scrollView:_collectionViewManagedByTaboola];
    
    _taboolaWidgetPlacement = [_classicPage createUnitWithPlacementName:placementBelowArticle mode:widgetMode_1x4];
    [_taboolaWidgetPlacement fetchContent];
    
    _taboolaFeedPlacement = [_classicPage createUnitWithPlacementName:placementFeedWithoutVideo mode:feedMode];
    [_taboolaFeedPlacement fetchContent];
}

#pragma mark - UICollectionViewDatasource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == taboolaWidgetSection) {
        // return a cell managed by Taboola SDK
        return [_taboolaWidgetPlacement collectionView:collectionView cellForItemAtIndexPath:indexPath withBackground:nil];
    }
    else if (indexPath.section == taboolaFeedSection) {
        // return a cell managed by Taboola SDK
        return [_taboolaFeedPlacement collectionView:collectionView cellForItemAtIndexPath:indexPath withBackground:nil];
    }
    else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:randomCell forIndexPath:indexPath];
        cell.contentView.backgroundColor = [RandomColor setRandomColor];
        return cell;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return totalSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == taboolaWidgetSection) {
        // return a widget cell size managed by Taboola SDK
        return [_taboolaWidgetPlacement collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath withUIInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    } else if (indexPath.section == taboolaFeedSection) {
        // return a feed cell size managed by Taboola SDK
        return [_taboolaFeedPlacement collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath withUIInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    }
    return CGSizeMake(collectionView.bounds.size.width, 200);
}

- (void)dealloc {
    [self.classicPage reset];
}

#pragma mark - TBLClassicPageDelegate

- (void)classicUnit:(UIView *)classicUnit didLoadOrResizePlacementName:(NSString *)placementName height:(CGFloat)height placementType:(PlacementType)placementType{
    NSLog(@"%@", placementName);
}

- (void)classicUnit:(UIView *)classicUnit didFailToLoadPlacementName:(NSString *)placementName errorMessage:(NSString *)error{
    NSLog(@"%@", error);
}

- (BOOL)classicUnit:(UIView *)classicUnit didClickPlacementName:(NSString *)placementName itemId:(NSString *)itemId clickUrl:(NSString *)clickUrl isOrganic:(BOOL)organic customData: (NSDictionary *)customData {
    return YES;
}

@end
