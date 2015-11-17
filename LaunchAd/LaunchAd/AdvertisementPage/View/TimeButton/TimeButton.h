//
//  TimeButton.h
//  ufenqi
//
//  Created by zhanggui on 15/10/27.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol TimeButtonDelegate <NSObject>

//@optional
//- (void)timeOut;
//
//@end
@interface TimeButton : UIButton

/**
 *  button
 *
 *  @param title title
 *  @param num   time
 *
 *  @return TimeButton
 */
- (id)initWithTitle:(NSString *)title andTime:(NSInteger)num;

//@property (nonatomic,assign)id <TimeButtonDelegate>delegate;
@property (nonatomic,assign)NSInteger timerNumber;  //time
@end
