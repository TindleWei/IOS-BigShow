//
//  BSNavView.h
//  BigShow
//
//  Created by tindle on 15/4/2.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSProgressView.h"
@interface BSNavView : UIView
@property (nonatomic,retain) BSProgressView *refreshView;
@property(nonatomic,retain)UIButton *arrowBtn;

//+(VZNavView*)shared;
+(float)height;

-(void)arrowDown;
-(void)arrowLeft;
-(void)showClose:(BOOL)flag;

@end

#define  REFRESH_TRIGGER 24
#define  REFRESH_HEIGHT 80