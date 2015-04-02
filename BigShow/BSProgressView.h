//
//  BSProgressView.h
//  BigShow
//
//  Created by tindle on 15/4/2.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSProgressView : UIView

@property(nonatomic,assign) BOOL autoCenter;

@property(nonatomic,retain) UIBezierPath *path;
@property(nonatomic,retain) UIColor *bgLineColor;
@property(nonatomic,retain) UIColor *fgLineColor;

@property(nonatomic,assign) BOOL infinite;
@property(nonatomic,assign) BOOL dashBgLine;
@property(nonatomic,assign) float progress;
@property(nonatomic,assign) float lineWidth;


- (id)initWithWidth:(float)width;

-(void)setProgress:(float)p animated:(BOOL)animated;

@end
