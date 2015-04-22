//
//  PhotoCollectionC.h
//  BigShow
//
//  Created by tindle on 15/4/21.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"

@interface PhotoCollectionC : UIViewController

//这里用assign而不用retain是为了防止引起循环引用。
@property(nonatomic,assign) NSObject<PassValueDelegate> *delegate;

@end
