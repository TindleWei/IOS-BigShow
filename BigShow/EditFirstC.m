//
//  EditFirstC.m
//  BigShow
//
//  Created by tindle on 15/4/20.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import "EditFirstC.h"

@interface EditFirstC()
@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UIImageView *avatarText;

@end

@implementation EditFirstC

-(void)viewDidLoad{
    [super viewDidLoad];
    self.titleText.delegate = self;
    self.nameText.delegate = self;
}


- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if(textField == _titleText){
        [_nameText becomeFirstResponder];
    }else if(textField == _nameText){
        [_nameText resignFirstResponder];
    }
    return YES;
}

@end
