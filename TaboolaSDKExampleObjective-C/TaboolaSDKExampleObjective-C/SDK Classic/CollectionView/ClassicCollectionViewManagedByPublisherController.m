//
//  ClassicCollectionViewManagedByPublisherController.m
//  TaboolaSDKExampleObjective-C
//
//  Copyright © 2020 Taboola. All rights reserved.
//

#import "ClassicCollectionViewManagedByPublisherController.h"
#import <TaboolaSDK/TaboolaSDK.h>
#import "RandomColor.h"

@interface ClassicCollectionViewManagedByPublisherController () <TBLClassicPageDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

// TBLClassicPage holds Taboola Widgets/Feed for a specific view
@property (nonatomic, strong) TBLClassicPage* classicPage;
// TBLClassicUnit object represnting Widget/Feed
@property (nonatomic, strong) TBLClassicUnit* taboolaWidgetPlacement;
@property (nonatomic, strong) TBLClassicUnit* taboolaFeedPlacement;

@end

@implementation ClassicCollectionViewManagedByPublisherController

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
        [weakSelf.collectionView.collectionViewLayout invalidateLayout];
    } completion:nil];
}

- (void)taboolaInit {
    _classicPage = [[TBLClassicPage alloc]initWithPageType:pageType pageUrl:pageUrl delegate:self scrollView:_collectionView];
    
    _taboolaWidgetPlacement = [_classicPage createUnitWithPlacementName:placementBelowArticle mode:widgetMode_1x4];
     [_taboolaWidgetPlacement fetchContent];
    
    _taboolaFeedPlacement = [_classicPage createUnitWithPlacementName:placementFeedWithoutVideo mode:feedMode];
    [_taboolaFeedPlacement fetchContent];
}

#pragma mark - UICollectionViewDatasource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == taboolaWidgetSection){
        UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:taboolaCollectionCell forIndexPath:indexPath];
        [self attachTaboolaUnit:_taboolaWidgetPlacement toCell:cell];
        return cell;
    } else if (indexPath.section == taboolaFeedSection){
        UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:taboolaCollectionCell forIndexPath:indexPath];
        [self attachTaboolaUnit:_taboolaFeedPlacement toCell:cell];
        return cell;
    } else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:randomCell forIndexPath:indexPath];
        cell.contentView.backgroundColor = [RandomColor setRandomColor];
        return cell;
    }
    
}

- (void)attachTaboolaUnit:(TBLClassicUnit *)unit toCell:(UICollectionViewCell *)cell {
    [self clearTaboolaInReusedCell:cell];
    // The unit fills the cell and follows its size from here on, e.g. on rotation or when the placement resizes
    unit.frame = cell.contentView.bounds;
    unit.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [cell.contentView addSubview:unit];
}

- (void)clearTaboolaInReusedCell:(UICollectionViewCell*)cell {
    for (UIView *view in [cell.contentView subviews]) {
        [view removeFromSuperview];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return totalSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Items span the collection view, which is inset from the screen edges by the safe area in landscape
    CGFloat width = collectionView.bounds.size.width;
    if (indexPath.section == taboolaWidgetSection) {
        return CGSizeMake(width, _taboolaWidgetPlacement.placementHeight);
    }
    else if (indexPath.section == taboolaFeedSection) {
        return CGSizeMake(width, _taboolaFeedPlacement.placementHeight);
    }
    return CGSizeMake(width, 200);
}

- (void)dealloc {
    [self.classicPage reset];
}

#pragma mark - TBLClassicPageDelegate

- (void)classicUnit:(UIView *)classicUnit didLoadOrResizePlacementName:(NSString *)placementName height:(CGFloat)height placementType:(PlacementType)placementType{
    NSLog(@"%@", placementName);

    // Item sizes are read from placementHeight; the unit follows its cell
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)classicUnit:(UIView *)classicUnit didFailToLoadPlacementName:(NSString *)placementName errorMessage:(NSString *)error{
    NSLog(@"%@", error);
}

- (BOOL)classicUnit:(UIView *)classicUnit didClickPlacementName:(NSString *)placementName itemId:(NSString *)itemId clickUrl:(NSString *)clickUrl isOrganic:(BOOL)organic customData: (NSDictionary *)customData {
    return YES;
}

@end
