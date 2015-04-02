//
//  BSSearchBar.h
//  BigShow
//
//  Created by tindle on 15/4/2.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSSearchBar;
@protocol BSSearchBar <NSObject,UITextFieldDelegate>

-(void)onSearchBarClose:(BSSearchBar*)searchBar;

@end

@interface BSSearchBar : UITextField
-(void)tiny;
@end
