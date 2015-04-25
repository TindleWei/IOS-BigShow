//
//  EditDataTool.m
//  BigShow
//
//  Created by tindle on 15/4/24.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import "DataEditTool.h"

static DataEditTool *_editDataTool = nil;

@implementation DataEditTool

+ (DataEditTool *)shareEditDateTool
{
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        _editDataTool = [[DataEditTool alloc] init];
    });

    return _editDataTool;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.array = [NSMutableArray array];
//        self.story = [[Story alloc] init];
        self.story = [Story object];
        self.slot = [[Slot alloc] init];
    }
    return self;
}



@end
