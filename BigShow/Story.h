//
//  Story.h
//  BigShow
//
//  Created by tindle on 15/4/7.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@interface Story : AVObject<AVSubclassing>

@property(nonatomic, copy) NSString *title;

@property(nonatomic, copy) NSString *cName;

@property(nonatomic, copy) NSString *cAvatar;

@property(nonatomic, copy) NSString *uid;

@property(nonatomic, copy) NSString *uName;

@property(nonatomic, copy) NSString *uAvatar;

@property(nonatomic, copy) NSString *status;

@property(nonatomic, copy) NSString *hotScore;

@end
