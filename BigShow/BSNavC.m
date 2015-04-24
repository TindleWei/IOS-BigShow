//
//  BSNavC.m
//  BigShow
//
//  Created by tindle on 15/4/2.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import "BSNavC.h"
//#import <MMDrawerController/MMDrawerController.h>
#import <UIViewController+MMDrawerController.h>

@interface BSNavC ()<UINavigationBarDelegate>
@property(nonatomic,strong)UIBarButtonItem *menuItem;
@end

@implementation BSNavC

- (void)viewDidLoad {
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 44, 44);
    [btn setImage:[UIImage imageNamed:@"Dots"] forState:UIControlStateNormal];
    
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -27, 0, 0)];
    
    [btn addTarget:self action:@selector(menu:) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.menuItem=left;
    
    UIViewController *vc = self.viewControllers[0];
    vc.navigationItem.leftBarButtonItem=self.menuItem;
    
//    vc.navigationController.navigationBar.backgroundColor = [UIColor redColor];
}

-(void)menu:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated{
    [super setViewControllers:viewControllers animated:animated];
    UIViewController *vc = viewControllers[0];
    vc.navigationItem.leftBarButtonItem=self.menuItem;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
