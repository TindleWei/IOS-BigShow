//
//  MBXSegmentControllerExampleViewController.m
//  MBXSegmentPageViewController
//
//  Created by Nico Arqueros on 12/21/14.
//  Copyright (c) 2014 Moblox. All rights reserved.
//

#import "EditSegmentC.h"
#import "MBXPageViewController.h"
#import "BSProgressView.h"

@interface EditSegmentC () <MBXPageControllerDataSource, MBXPageControllerDataDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentController;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic,retain) BSProgressView *refreshView;

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
    
    self.title = @"EditSegment";
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:108.f/255.f green:105.f/255.f blue:164.f/255.f alpha:1.0];
    
    [self initSaveBtn];
    
}

-(void)initSaveBtn{
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(onSaveBtn:)];
    
    
//    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    searchBtn.frame=CGRectMake(0, 0, 44, 44);
//    [searchBtn setImage:[UIImage imageNamed:@"side_button"] forState:UIControlStateNormal];
//    [searchBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [searchBtn addTarget:self action:@selector(onSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:searchBtn];
}

-(void)onSaveBtn:(UIButton*)btn{
    NSLog(@"onSaveBtn");
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
//    NSLog(@"%@ %ld", [self class], (long)index);
}

@end
