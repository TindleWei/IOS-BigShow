//
//  EndsTableCell.m
//  BigShow
//
//  Created by tindle on 15/4/23.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import "EndsTableCell.h"

@interface EndsTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *orderText;
@property (weak, nonatomic) IBOutlet UITextField *contentText;
@property (weak, nonatomic) IBOutlet UILabel *statusText;
@property (weak, nonatomic) IBOutlet UIImageView *deleteImage;


@end

@implementation EndsTableCell

-(void)setKeyTypeDone{
    [self.contentText setReturnKeyType: UIReturnKeyDone];
}

-(void)setSelected:(BOOL)selected {
    
    if (selected){
        self.backgroundColor = [UIColor colorWithRed:108.f/255.f green:105.f/255.f blue:164.f/255.f alpha:1.0];
    } else {
        self.backgroundColor = [UIColor colorWithRed:102.f/255.f green:99.f/255.f blue:157.f/255.f alpha:1.0];
    }
    
}


@end
