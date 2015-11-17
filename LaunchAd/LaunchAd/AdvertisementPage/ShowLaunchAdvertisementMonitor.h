//
//  ShowLaunchAdvertisementMonitor.h
//  ufenqi
//
//  Created by zhanggui on 15/10/27.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ShowLaunchAdvertisementMonitor : NSObject
/**
 *  SingletonMethod
 *
 *  @return Return SingletonMethod
 */
+ (instancetype)shared;

/**
 *  if you want to set local ad ,you can use this method
 *
 *  @param container
 *  @param complete
 *  @param interval
 */
+ (void)showAdvertisementOnView:(UIView *)container detailParams:(NSDictionary *)params completetion:(dispatch_block_t)complete;

/**
 *  if you want to load ad form server ,you can use this method
 *
 *  @param container
 *  @param complete
 *  @param interval  
 */
+ (void)showAdvertisementOnView:(UIView *)container completetion:(dispatch_block_t)complete;

@end
