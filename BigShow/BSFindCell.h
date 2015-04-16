//
//  BSFindCell.h
//  BigShow
//
//  Created by tindle on 15/4/7.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Story.h"

@interface BSFindCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *storyImage;
@property (weak, nonatomic) IBOutlet UIImageView *characterImage;
@property (weak, nonatomic) IBOutlet UILabel *characterLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *container;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic) BOOL canAnimate;

@property (weak, nonatomic) Story *story;
@property (weak, nonatomic) UITableView *table;

-(void)loadPhoto;
-(void)stopLoadPhoto;

@end
