//
//  ClassicMainScrollViewController.m
//  TaboolaSDKExampleObjective-C
//
//  Created by Sasa Jovanovic on 15.1.25..
//

#import "ClassicMainScrollViewController.h"
#import "ClassicFrameMetaAdController.h"
#import "ClassicFrameScrollViewController.h"
#import "ClassicConstraintsMetaAdViewController.h"
#import "ClassicConstraintsScrollViewController.h"

@implementation ClassicMainScrollViewController

// MARK: - View life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

// MARK: - Actions
- (IBAction)didTapFrames:(UIButton *)sender {
    if (self.isForMetaAds) { // Go to Taboola with Meta integration screen
        ClassicFrameMetaAdController *viewController = [ClassicFrameMetaAdController new];
        [self.navigationController pushViewController:viewController animated:YES];
    } else { // Go to Taboola only screen
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ClassicFrameScrollViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ClassicFrameScrollViewController"];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (IBAction)didTapConstraints:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (self.isForMetaAds) { // Go to Taboola with Meta integration screen
        ClassicConstraintsMetaAdViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ClassicConstraintsMetaAdViewController"];
        [self.navigationController pushViewController:viewController animated:YES];
    } else { // Go to Taboola only screen
        ClassicConstraintsScrollViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ClassicConstraintsScrollViewController"];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
