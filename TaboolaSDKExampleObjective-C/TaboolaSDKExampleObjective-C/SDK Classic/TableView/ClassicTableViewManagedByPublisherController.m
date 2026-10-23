//
//  ClassicTableViewManagedByPublisherController.m
//  TaboolaSDKExampleObjective-C
//
//  Copyright © 2020 Taboola. All rights reserved.
//

#import "ClassicTableViewManagedByPublisherController.h"
#import <TaboolaSDK/TaboolaSDK.h>
#import "RandomColor.h"

@interface ClassicTableViewManagedByPublisherController () <TBLClassicPageDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// TBLClassicPage holds Taboola Widgets/Feed for a specific view
@property (nonatomic, strong) TBLClassicPage* classicPage;
// TBLClassicUnit object represnting Widget/Feed
@property (nonatomic, strong) TBLClassicUnit* taboolaWidgetPlacement;
@property (nonatomic, strong) TBLClassicUnit* taboolaFeedPlacement;

@end

@implementation ClassicTableViewManagedByPublisherController

#pragma mark - ViewController lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self taboolaInit];
}

- (void)taboolaInit {
    _classicPage = [[TBLClassicPage alloc]initWithPageType:pageType pageUrl:pageUrl delegate:self scrollView:_tableView];
    
    _taboolaWidgetPlacement = [_classicPage createUnitWithPlacementName:placementBelowArticle mode:widgetMode_1x4];
     [_taboolaWidgetPlacement fetchContent];
    
    _taboolaFeedPlacement = [_classicPage createUnitWithPlacementName:placementFeedWithoutVideo mode:feedMode];
    [_taboolaFeedPlacement fetchContent];
}

#pragma mark - UITableViewDatasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == taboolaWidgetSection){
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:taboolaTableCell forIndexPath:indexPath];
        [self attachTaboolaUnit:_taboolaWidgetPlacement toCell:cell];
        return cell;
    }
    else if (indexPath.section == taboolaFeedSection){
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:taboolaTableCell forIndexPath:indexPath];
        [self attachTaboolaUnit:_taboolaFeedPlacement toCell:cell];
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:randomCell forIndexPath:indexPath];
        cell.contentView.backgroundColor = [RandomColor setRandomColor];
        return cell;
    }
}

- (void)attachTaboolaUnit:(TBLClassicUnit *)unit toCell:(UITableViewCell *)cell {
    [self clearTaboolaInReusedCell:cell];
    // The unit fills the cell and follows its size from here on, e.g. on rotation or when the placement resizes
    unit.frame = cell.contentView.bounds;
    unit.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [cell.contentView addSubview:unit];
}

- (void)clearTaboolaInReusedCell:(UITableViewCell*)cell {
    for (UIView *view in [cell.contentView subviews]) {
        [view removeFromSuperview];
    }
}
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return totalSections;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        if (indexPath.section == taboolaWidgetSection) {
            return _taboolaWidgetPlacement.placementHeight;
        }
        else if (indexPath.section == taboolaFeedSection) {
            return _taboolaFeedPlacement.placementHeight;
        }
        return 200;
}

- (void)dealloc {
    [self.classicPage reset];
}

#pragma mark - TBLClassicPageDelegate

- (void)classicUnit:(UIView *)classicUnit didLoadOrResizePlacementName:(NSString *)placementName height:(CGFloat)height placementType:(PlacementType)placementType{
    NSLog(@"%@", placementName);

    // Row heights are read from placementHeight; the unit follows its cell
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (void)classicUnit:(UIView *)classicUnit didFailToLoadPlacementName:(NSString *)placementName errorMessage:(NSString *)error{
    NSLog(@"%@", error);
}

- (BOOL)classicUnit:(UIView *)classicUnit didClickPlacementName:(NSString *)placementName itemId:(NSString *)itemId clickUrl:(NSString *)clickUrl isOrganic:(BOOL)organic customData: (NSDictionary *)customData {
    return YES;
}

@end
