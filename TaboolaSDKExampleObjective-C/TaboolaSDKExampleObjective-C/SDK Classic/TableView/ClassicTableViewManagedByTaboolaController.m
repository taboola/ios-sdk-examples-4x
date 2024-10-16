//
//  ClassicTableViewManagedByTaboolaController.m
//  TaboolaSDKExampleObjective-C
//
//  Copyright © 2020 Taboola. All rights reserved.
//

#import "ClassicTableViewManagedByTaboolaController.h"
#import <TaboolaSDK/TaboolaSDK.h>
#import "RandomColor.h"

@interface ClassicTableViewManagedByTaboolaController () <TBLClassicPageDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableViewManagedByTaboola;

// TBLClassicPage holds Taboola Widgets/Feed for a specific view
@property (nonatomic, strong) TBLClassicPage* classicPage;
// TBLClassicUnit object represnting Widget/Feed
@property (nonatomic, strong) TBLClassicUnit* taboolaWidgetPlacement;
@property (nonatomic, strong) TBLClassicUnit* taboolaFeedPlacement;

@end

@implementation ClassicTableViewManagedByTaboolaController

#pragma mark - ViewController lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self taboolaInit];
}

- (void)taboolaInit {
    _classicPage = [[TBLClassicPage alloc]initWithPageType:pageType pageUrl:pageUrl delegate:self scrollView:_tableViewManagedByTaboola];
    
    _taboolaWidgetPlacement = [_classicPage createUnitWithPlacementName:placementBelowArticle mode:widgetMode_1x4];
     [_taboolaWidgetPlacement fetchContent];
    
    _taboolaFeedPlacement = [_classicPage createUnitWithPlacementName:placementFeedWithoutVideo mode:feedMode];
    [_taboolaFeedPlacement fetchContent];
}

#pragma mark - UITableViewDatasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == taboolaWidgetSection) {
        return [_taboolaWidgetPlacement tableView:tableView cellForRowAtIndexPath:indexPath withBackground:nil];
    
    }
    else if (indexPath.section == taboolaFeedSection) {
        return [_taboolaFeedPlacement tableView:tableView cellForRowAtIndexPath:indexPath withBackground:nil];
    }
    else {
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:randomCell forIndexPath:indexPath];
        cell.contentView.backgroundColor = [RandomColor setRandomColor];
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return totalSections;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == taboolaWidgetSection) {
        return [_taboolaWidgetPlacement tableView:tableView heightForRowAtIndexPath:indexPath withUIInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    }
    else if (indexPath.section == taboolaFeedSection) {
        return [_taboolaFeedPlacement tableView:tableView heightForRowAtIndexPath:indexPath withUIInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    }
    return 200;
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
