//
//  EndsTableCell.h
//  BigShow
//
//  Created by tindle on 15/4/23.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EndsTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderText;
@property (weak, nonatomic) IBOutlet UITextField *contentText;
@property (weak, nonatomic) IBOutlet UILabel *statusText;
@property (weak, nonatomic) IBOutlet UIImageView *deleteImage;


-(void)setKeyTypeDone;

@end
