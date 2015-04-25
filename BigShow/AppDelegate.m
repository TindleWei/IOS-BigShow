//
//  AppDelegate.m
//  BigShow
//
//  Created by tindle on 15/3/31.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import "AppDelegate.h"
#import <AVOSCloud/AVOSCloud.h>

#import "BSMenuC.h"
#import "BSM.h"

#import <MMDrawerController/MMDrawerController.h>
#import "BSNavView.h"
#import "Story.h"
#import "Slot.h"
#import "End.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [AVOSCloud setApplicationId:@"bp8bg4jqsnvc719ozomgp0ohvt6qa2n03o7e5sfe95v69j05" clientKey:@"u5rlevm51o2xjgvmkadomjk7lzfezhsir8fdjprmbz44x4dz"];
    [AVOSCloud setLastModifyEnabled:YES];
    [AVAnalytics setCrashReportEnabled:YES];
    
    [Story registerSubclass];
    [Slot registerSubclass];
    [End registerSubclass];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"navBg"]
                                                      stretchableImageWithLeftCapWidth:25 topCapHeight:1] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearance] setBackgroundImage:[UIImage new] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    if (is7orLater()) {
        [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"arrow"]];
        [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"arrow"]];
        
        [UIBarButtonItem.appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -64) forBarMetrics:UIBarMetricsDefault];
        
        self.window.tintColor = [UIColor whiteColor];
        
    }else{
        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[[UIImage imageNamed:@"arrow"] stretchableImageWithLeftCapWidth:16 topCapHeight:0] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    }
    
    model;
    
    self.window.backgroundColor=[UIColor blackColor];
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[BSTheme bgImage]];
    bg.alpha=0.8;
    [self.window addSubview:bg];
    
    
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main" bundle:Nil];
    
    BSMenuC *menuC = [board instantiateViewControllerWithIdentifier:@"menuC"];
    
    UINavigationController *nav = [board instantiateInitialViewController];
    
    if ([nav respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        nav.interactivePopGestureRecognizer.enabled = YES;
    }
    
    MMDrawerController *menu = [[MMDrawerController alloc]initWithCenterViewController:nav leftDrawerViewController:menuC];
    menu.openDrawerGestureModeMask=MMOpenDrawerGestureModeNone;
    menu.closeDrawerGestureModeMask=MMCloseDrawerGestureModeTapCenterView;
    menu.maximumLeftDrawerWidth=128;
    
    menu.maximumRightDrawerWidth=64;
    
    self.window.rootViewController=menu;
    menu.view.backgroundColor=[UIColor clearColor];
    [self.window makeKeyAndVisible];
    
#if !TARGET_IPHONE_SIMULATOR
    [application registerForRemoteNotificationTypes:
    UIRemoteNotificationTypeBadge |
    UIRemoteNotificationTypeAlert |
    UIRemoteNotificationTypeSound];
#endif
    
    return YES;
}

-(void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    AVInstallation *currentInstallation = [AVInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    
    NSMutableArray *channels=[NSMutableArray arrayWithArray:currentInstallation.channels];
    if (![channels containsObject:@"update"]){
        [channels addObject:@"update"];
        currentInstallation.channels=channels;
        [currentInstallation saveInBackground];
    }
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    [AVAnalytics event:@"开启推送失败" label:[error description]];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [AVAnalytics trackAppOpenedWithRemoteNotificationPayload:nil];
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [AVOSCloudSNS handleOpenURL:url];
}


@end
