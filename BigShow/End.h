//
//  End.h
//  BigShow
//
//  Created by tindle on 15/4/23.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@class Slot;

@interface End : AVObject<AVSubclassing>

@property(nonatomic, copy) NSString *choosenContent;

@property(nonatomic, copy) NSString *endContent;

@property(nonatomic, copy) NSString *endPhoto;

@property(nonatomic, retain) Slot *fromSlot;

@property(nonatomic, copy) NSString *isCompleted;

@property(nonatomic, copy) NSString *endNext;

@end
