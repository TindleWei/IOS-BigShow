//
//  MBXSegmentControllerExampleViewController.m
//  MBXSegmentPageViewController
//
//  Created by Nico Arqueros on 12/21/14.
//  Copyright (c) 2014 Moblox. All rights reserved.
//

#import "EditSegmentC.h"
#import "MBXPageViewController.h"

@interface EditSegmentC () <MBXPageControllerDataSource, MBXPageControllerDataDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentController;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation EditSegmentC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initiate MBXPageController
    MBXPageViewController *MBXPageController = [MBXPageViewController new];
    MBXPageController.MBXDataSource = self;
    MBXPageController.MBXDataDelegate = self;
    MBXPageController.pageMode = MBX_SegmentController;
    [MBXPageController reloadPages];
}

#pragma mark - MBXPageViewController Data Source

- (NSArray *)MBXPageButtons
{
    return @[self.segmentController];
}

- (UIView *)MBXPageContainer
{
    return self.containerView;
}

- (NSArray *)MBXPageControllers
{
    // You can Load a VC directly from Storyboard
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *demo  = [mainStoryboard instantiateViewControllerWithIdentifier:@"edit_first"];
    UIViewController *demo2  = [mainStoryboard instantiateViewControllerWithIdentifier:@"edit_second"];
    UIViewController *demo3 = [mainStoryboard instantiateViewControllerWithIdentifier:@"edit_third"];
    
    // The order matters.
    return @[demo,demo2, demo3];
}



#pragma mark - MBXPageViewController Delegate

- (void)MBXPageChangedToIndex:(NSInteger)index
{
    NSLog(@"%@ %ld", [self class], (long)index);
}

@end
