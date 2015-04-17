//
//  WebViewC.h
//  BigShow
//
//  Created by tindle on 15/4/17.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/SKStoreProductViewController.h>

#import <SIAlertView/SIAlertView.h>

@interface WebViewC : UIViewController<UIWebViewDelegate>
@property(nonatomic,strong) UIWebView *webView;

-(void)loadURL:(NSString*)url;

@end
