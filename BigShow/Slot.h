//
//  Slot.h
//  BigShow
//
//  Created by tindle on 15/4/23.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@class Story;

@interface Slot : AVObject<AVSubclassing>

@property(nonatomic, assign) NSInteger *pageOrder;

@property(nonatomic, copy) NSString *slotContent;

@property(nonatomic, copy) NSString *slotPhoto;

@property(nonatomic, copy) NSString *slotQuestion;

@property(nonatomic, copy) NSString *isCompleted;

@property(nonatomic, retain) Story *fromStory;

@end
