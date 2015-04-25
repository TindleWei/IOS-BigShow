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

@property(nonatomic, copy) NSString *storyTitle;

@property(nonatomic, copy) NSString *storyName;

@property(nonatomic, copy) NSString *storyAvatar;

@property(nonatomic, copy) NSString *userId;

@property(nonatomic, copy) NSString *userName;

@property(nonatomic, copy) NSString *userAvatar;

@property(nonatomic, copy) NSString *isCompleted;

@property(nonatomic, assign) NSInteger *hotScore;

#pragma mark - add
@property(nonatomic, strong) UIImage *avatarFile;

@end
