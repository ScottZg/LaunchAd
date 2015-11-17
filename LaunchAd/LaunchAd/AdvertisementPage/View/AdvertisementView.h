//
//  AdvertisementView.h
//  ufenqi
//
//  Created by zhanggui on 15/10/27.
//  Copyright © 2015年 mac. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,AnimationType) {
    ADAnimationTypeSlideUp = 10,   //
    ADAnimationTypeSlideDown,   //
    ADAnimationTypeSlideLeft,   //
    ADAnimationTypeSlideRight,  //
    ADAnimationTypeCurlUp,    //
    ADAnimationTypeSlowDisappear,  //
    ADAnimationTypeZoom    //
};

@interface AdvertisementView : UIView
/**
 *  close method
 */
- (void)closeAction;

@property (nonatomic,assign)AnimationType AdAnimationType;

@property (nonatomic,copy)dispatch_block_t block;

/**
 *  set the infomation that adview needs to show
 *
 *  @param dic information dic
 */
- (void)setShowDetails:(NSDictionary *)dic;
@end
