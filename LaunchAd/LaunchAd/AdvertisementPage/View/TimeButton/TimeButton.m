//
//  TimeButton.m
//  ufenqi
//
//  Created by zhanggui on 15/10/27.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "TimeButton.h"
@implementation TimeButton
{
    
    NSTimer *timer;
    NSString *titleStr;
}
- (id)initWithTitle:(NSString *)title andTime:(NSInteger)num {
    self = [super init];
    if (self) {
        timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateTitleAction) userInfo:nil repeats:YES];
        titleStr = title;
        self.timerNumber = num;
        [self setTitle:[NSString stringWithFormat:@"%@%lds",title,(long)num] forState:UIControlStateNormal];
        [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
        
    }
    return self;
}
- (void)updateTitleAction {
    if (self.timerNumber<=1) {
        [timer invalidate];
        timer = nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TIMEOUT" object:nil];
        return;
    }
    self.timerNumber--;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setTitle:[NSString stringWithFormat:@"%@%lds",titleStr,(long)self.timerNumber] forState:UIControlStateNormal];
    });
    
}

@end
