//
//  AppDelegate.m
//  QiButton_UIButtonType
//
//  Created by wangyongwang on 2018/8/5.
//  Copyright © 2018年 QiShare. All rights reserved.
//

#import "AppDelegate.h"
#import "QiButton_ButtonTypeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    _window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[QiButton_ButtonTypeViewController new]];
    
    [_window makeKeyAndVisible];
    
    return YES;
}

@end
