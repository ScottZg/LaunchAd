//
//  AppDelegate.m
//  LaunchAd
//
//  Created by zhanggui on 15/11/17.
//  Copyright © 2015年 zhanggui. All rights reserved.
//

#import "AppDelegate.h"
#import "ShowLaunchAdvertisementMonitor.h"
#import "MyViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:[[MyViewController alloc] init]];
    
    self.window.rootViewController=nav;
    
    [self.window makeKeyAndVisible];

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:4];
    [dic setValue:@"5" forKey:@"countDown"];
    [dic setValue:@"http://www.taskcity.com/files/0022/1227/1.png?1399453287" forKey:@"picuri"];
    [dic setValue:@"www.baidu.com" forKey:@"detailuri"];
    [ShowLaunchAdvertisementMonitor showAdvertisementOnView:self.window detailParams:dic completetion:^{
        NSLog(@"advertisment page disapper");
    }];
    

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
