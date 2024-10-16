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
        [self clearTaboolaInReusedCell:cell];
        [cell.contentView addSubview:_taboolaWidgetPlacement];
        return cell;
    } else if (indexPath.section == taboolaFeedSection){
        UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:taboolaCollectionCell forIndexPath:indexPath];
        [self clearTaboolaInReusedCell:cell];
        [cell.contentView addSubview:_taboolaFeedPlacement];
        return cell;
    } else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:randomCell forIndexPath:indexPath];
        cell.contentView.backgroundColor = [RandomColor setRandomColor];
        return cell;
    }
    
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
    if (indexPath.section == taboolaWidgetSection) {
        return CGSizeMake(self.view.frame.size.width, _taboolaWidgetPlacement.placementHeight);
    }
    else if (indexPath.section == taboolaFeedSection) {
        return CGSizeMake(self.view.frame.size.width, _taboolaFeedPlacement.placementHeight);
    }
    return CGSizeMake(self.view.frame.size.width, 200);
}

- (void)dealloc {
    [self.classicPage reset];
}

#pragma mark - TBLClassicPageDelegate

- (void)classicUnit:(UIView *)classicUnit didLoadOrResizePlacementName:(NSString *)placementName height:(CGFloat)height placementType:(PlacementType)placementType{
    NSLog(@"%@", placementName);
    
    if ([placementName containsString:placementBelowArticle]) {
        [_taboolaWidgetPlacement setFrame:CGRectMake(0, 0, self.view.frame.size.width, _taboolaWidgetPlacement.placementHeight)];
    } else {
        [_taboolaFeedPlacement setFrame:CGRectMake(_taboolaFeedPlacement.frame.origin.x, _taboolaFeedPlacement.frame.origin.y, self.view.frame.size.width, _taboolaFeedPlacement.placementHeight)];
    }
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)classicUnit:(UIView *)classicUnit didFailToLoadPlacementName:(NSString *)placementName errorMessage:(NSString *)error{
    NSLog(@"%@", error);
}

- (BOOL)classicUnit:(UIView *)classicUnit didClickPlacementName:(NSString *)placementName itemId:(NSString *)itemId clickUrl:(NSString *)clickUrl isOrganic:(BOOL)organic customData: (NSDictionary *)customData {
    return YES;
}

@end
