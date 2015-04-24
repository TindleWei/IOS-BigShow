//
//  EditDataTool.h
//  BigShow
//
//  Created by tindle on 15/4/24.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Story.h"
#import "Slot.h"
#import "End.h"

@interface DataEditTool : NSObject

@property (nonatomic, strong) Story *story;
@property (nonatomic, strong) Slot *slot;
@property (nonatomic, strong) NSMutableArray *array;

+ (DataEditTool *)shareEditDateTool;

+ (NSMutableArray *)getArray;

+ (void)setArray;

@end
