//
//  BSStacView.h
//  BigShow
//
//  Created by tindle on 15/4/2.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSStacView;
@protocol BSStacViewDelegate <NSObject>

-(void)stacViewOpenChanged:(BSStacView*)stacView;

@end

@interface BSStacView : UIView
@property(nonatomic, assign)CGRect initFrame;
@property(nonatomic, assign) BOOL open;
@property(nonatomic, assign) id<BSStacViewDelegate> delegate;

-(void)addImage:(UIImage*)img;

-(void)scroll:(float)y;

@end
