//
//  ShowLaunchAdvertisementMonitor.m
//  ufenqi
//
//  Created by zhanggui on 15/10/27.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "ShowLaunchAdvertisementMonitor.h"
#import "AdvertisementView.h"
//#import "GetAdvertisementRequest.h"
@interface ShowLaunchAdvertisementMonitor ()


@end


@implementation ShowLaunchAdvertisementMonitor

+ (instancetype)shared {
    static ShowLaunchAdvertisementMonitor *showAdMonitor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        showAdMonitor = [ShowLaunchAdvertisementMonitor new];
    });
    return showAdMonitor;
}

+ (void)showAdvertisementOnView:(UIView *)container detailParams:(NSDictionary *)params completetion:(dispatch_block_t)complete  {
    AdvertisementView *adView = [[AdvertisementView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    adView.AdAnimationType = ADAnimationTypeZoom;//set animations
    adView.block = complete;
    
    [adView setShowDetails:params];   //set the content that adView needs to show
    [container addSubview:adView];   //add the view to the view that you want to show
}
+ (void)showAdvertisementOnView:(UIView *)container completetion:(dispatch_block_t)complete {
    AdvertisementView *adView = [[AdvertisementView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //    adView.AdAnimationType = ADAnimationTypeZoom;//set animations
    adView.block = complete;
        //request server to get informations and the add the information toadView's detail contents
//    GetAdvertisementRequest *adRequest = [[GetAdvertisementRequest alloc] init];
    //params is requested data
//    [adView setShowDetails:params];

    
    [container addSubview:adView];   //add to container
}
@end
