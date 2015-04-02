//
//  BSM.h
//  BigShow
//
//  Created by tindle on 15/4/2.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudSNS/AVOSCloudSNS.h>
#import <AVOSCloudSNS/AVUser+SNS.h>

#import <AVOSCloud/AVHTTPClient.h>

BOOL is7orLater();

typedef enum{
    BSThemeTypeModern = 0,
    BSThemeTypeLight
} BSThemeType;

@interface BSTheme : NSObject
+(void)changeTheme:(BSThemeType)theme;
+(UIColor *)textColor;
+(UIColor *)bgColor;
+(UIImage *)bgImage;
@end

@interface BSM : NSObject

@property(nonatomic,assign) BOOL showAroundOnly;

@property(nonatomic,assign) BOOL showPostsWithPicsOnly;
@property(nonatomic,assign) BSThemeType theme;

@property(nonatomic,retain) AVHTTPClient *client;

+(BSM*)shared;

+(NSString*)storeIdOfURL:(NSString*)url;

-(void)login:(AVUserResultBlock)callback;
-(void)logout;

-(void)getCommentWithWbid:(NSString*)wbid callback:(AVArrayResultBlock)callback;
-(void)commentToWbid:(NSString*)wbid toCommentId:(NSString*)cid withText:(NSString*)
text callback:(AVSNSResultBlock)callback;

-(void)uploadImage:(UIImage*)image callback:(AVSNSResultBlock)callback;
@end

#define model [BSM shared]

@interface BSUser : AVUser<AVSubclassing>

@property(nonatomic, copy) NSString *avatar;
@property(nonatomic, readonly) NSString *wbid;
-(NSString*)wbid;

/**
 *  查找来着微博的好友
 *
 *  @param callback 回调返回好友ID数字
 */
-(void)findMyFriendOnWeibo:(AVArrayResultBlock)callback;

//-(void)watch:(BOOL)flat post:(VZPost*)post callback:(AVBooleanResultBlock)callback;

@end
