//
//  BSNavView.m
//  BigShow
//
//  Created by tindle on 15/4/2.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import "BSNavView.h"

@interface BSNavView(){
    UIView *contentView;
}
@property(nonatomic,retain)UIButton *closeBtn;
@end

@implementation BSNavView

+(float)height{
    return 64;
}

+(BSNavView*)shared{
    static BSNavView *_nav_=Nil;
    if (_nav_==Nil) {
        _nav_=[BSNavView new];
    }
    return _nav_;
}

- (id)init
{
    CGRect frame=CGRectMake(0, 0, 320, [BSNavView height]);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithWhite:0 alpha:0.4];
        
        contentView=[[UIView alloc] initWithFrame:CGRectMake(0, [BSNavView height]==64?20:0, frame.size.width, 44)];
        
        self.refreshView=[[BSProgressView alloc] initWithWidth:44];
        self.refreshView.progress=1.0;
        [contentView addSubview:self.refreshView];
        
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(10, 0, 44, 44);
        [btn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        
        [contentView addSubview:btn];
        self.arrowBtn=btn;
        
        
        
        btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(10, 0, 44, 44);
        [btn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onClose:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:btn];
        self.closeBtn=btn;
        self.closeBtn.alpha=0;
        
        [self addSubview:contentView];
    }
    return self;
}

-(void)arrowDown{
    [UIView animateWithDuration:0.2 animations:^{
        [self.arrowBtn setTransform:CGAffineTransformMakeRotation(-M_PI /2)];
    }];
}

-(void)arrowLeft{
    [UIView animateWithDuration:0.2 animations:^{
        [self.arrowBtn setTransform:CGAffineTransformMakeRotation(M_PI /2)];
    }];
}

-(void)showClose:(BOOL)flag{
    static BOOL isCloseShow;
    if (isCloseShow==flag) {
        return;
    }
    
    isCloseShow=flag;
    if (flag) {
        self.closeBtn.alpha=0;
        self.closeBtn.center=CGPointMake(82, 22);
        
        [UIView animateWithDuration:0.2 animations:^{
            self.closeBtn.alpha=1;
            self.closeBtn.center=CGPointMake(22, 22);
            
            self.arrowBtn.alpha=0;
            self.arrowBtn.center=CGPointMake(-22, 22);
        }];
        
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            self.arrowBtn.alpha=1;
            self.arrowBtn.center=CGPointMake(32, 22);
            
            self.closeBtn.alpha=0;
            self.closeBtn.center=CGPointMake(82, 22);
        }];
    }
}

-(void)onClose:(UIButton*)btn{
    
    [self showClose:NO];
}


@end
