//
//  AdvertisementView.m
//  ufenqi
//
//  Created by zhanggui on 15/10/27.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "AdvertisementView.h"
#import "Masonry.h"
#import "TimeButton.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "UIView+Extension.h"
#define CORNERRADIUSNUM 5.0
#define CLOSEVIEWCORSUM 10
#define RGBCOLOR(R,G,B,L) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:L]

@interface AdvertisementView ()
@property (nonatomic,assign)NSInteger timeNum;   //time
@property (nonatomic,strong)NSURLConnection *conn;
@property (nonatomic,strong)TimeButton *closeButton;
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UIButton *showDetailButton;
@property (nonatomic,strong)UIView *buttonBackView;
@property (nonatomic,copy)NSString *showDetailURI;
@end
@implementation AdvertisementView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeAction) name:@"TIMEOUT" object:nil];
        self.backgroundColor = [UIColor whiteColor];
        [self initImageConstarints];
    }
    return self;
}
#pragma mark - init layout
- (void)initImageConstarints {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
- (void)initConstarints {
    
    [self.buttonBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(20);
        make.width.equalTo(self.closeButton.mas_width);
        make.height.equalTo(self.closeButton.mas_height);
    }];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(20);
        make.width.equalTo(@60);
    }];
    
    [self.showDetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-25);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
}
#pragma mark - 加载要显示的内容
- (void)setShowDetails:(NSDictionary *)dic {
    if (dic) {  //success
        [self loadImageWithPath:dic[@"picuri"]];
        self.showDetailURI = dic[@"detailuri"];
        self.timeNum = [[dic objectForKey:@"countDown"] intValue];
        [self initConstarints];
    }else {   //fail,close ad view
        [self closeAction];
    }
    
    
}
/**
 *  you'd better to set placeH image is equal to launchimage.because that can give user's a virtual screen that the loading image times show launchimage.
 *
 */
- (void)loadImageWithPath:(NSString *)imagePath {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:[UIImage imageNamed:@"placeH"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            //iOS9 may load failed .you can see:http://www.cocoachina.com/bbs/read.php?tid=306204
            //
            NSLog(@"loading fail...");
            [self closeAction];
        }else {
            [self updateUI];
        }

    }];
}
- (void)updateUI {
    self.closeButton.hidden = NO;
    self.buttonBackView.hidden = NO;
    self.showDetailButton.hidden = NO;
}
#pragma mark - LazyLoad

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
        _imageView.image = [UIImage imageNamed:@"placeH"];
        
        [self addSubview:_imageView];
    }
    return _imageView;
}
- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [[TimeButton alloc] initWithTitle:@"Skip" andTime:self.timeNum];
        [_closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        _closeButton.layer.borderColor = [UIColor whiteColor].CGColor;
        [_closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _closeButton.hidden = YES;
        _closeButton.titleLabel.font = [UIFont systemFontOfSize:11];
        _closeButton.tintColor = [UIColor whiteColor];
        _closeButton.layer.cornerRadius = CLOSEVIEWCORSUM;
        _closeButton.layer.borderWidth = 0.5f;
        
        [self.imageView addSubview:_closeButton];
    }
    return _closeButton;
}
- (UIView *)buttonBackView {
    if (!_buttonBackView) {
        _buttonBackView = [[UIView alloc] init];
        _buttonBackView.backgroundColor = [UIColor whiteColor];
        _buttonBackView.alpha = 0.2f;
        _buttonBackView.hidden = YES;
        _buttonBackView.layer.cornerRadius = CLOSEVIEWCORSUM;
        [self.imageView addSubview:_buttonBackView];
    }
    return _buttonBackView;
}
- (UIButton *)showDetailButton {
    if (!_showDetailButton) {
        _showDetailButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_showDetailButton addTarget:self action:@selector(showDetailAction) forControlEvents:UIControlEventTouchUpInside];
        [_showDetailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_showDetailButton setTitle:@"Go" forState:UIControlStateNormal];
        [_showDetailButton setTitleColor:RGBCOLOR(254, 151, 52, 1.0f) forState:UIControlStateNormal];
        _showDetailButton.layer.cornerRadius = CORNERRADIUSNUM;
        _showDetailButton.layer.borderWidth = 1.5f;
        _showDetailButton.layer.borderColor  = RGBCOLOR(254, 151, 52, 1.0f).CGColor;
        _showDetailButton.hidden = YES;
        [self.imageView addSubview:_showDetailButton];
    }
    return _showDetailButton;
}
#pragma mark - close action
- (void)closeAction {
    switch (self.AdAnimationType) {
        case ADAnimationTypeCurlUp:
        {
            [UIView animateWithDuration:1.6 animations:^{
                [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self cache:YES];
                self.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                self.block();
            }];
        }
            
            break;
        case ADAnimationTypeSlideDown:
        {
            [UIView animateWithDuration:1.5 animations:^{
                self.frame = CGRectMake(0,self.height, self.width, self.height);
                //        self.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                self.block();
            }];
        }
            
            break;
        case ADAnimationTypeSlideLeft:
        {
            [UIView animateWithDuration:1.5 animations:^{
                self.frame = CGRectMake(-self.width,0, self.width, self.height);
                //        self.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                self.block();
            }];
        }
            break;
        case ADAnimationTypeSlideRight:
        {
            [UIView animateWithDuration:1.5 animations:^{
                self.frame = CGRectMake(self.width,0, self.width, self.height);
                //        self.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                self.block();
            }];
        }
            break;
        case ADAnimationTypeSlideUp:
        {
            {
                [UIView animateWithDuration:1.5 animations:^{
                    self.frame = CGRectMake(0,-self.height, self.width, self.height);
                    //        self.alpha = 0.0f;
                } completion:^(BOOL finished) {
                    [self removeFromSuperview];
                    self.block();
                }];
            }
            
        }
            break;
        case ADAnimationTypeSlowDisappear:
        {
            [UIView animateWithDuration:0.25 animations:^{
                self.alpha = 0.0f;
            } completion:^(BOOL finished) {
                if (self.superview) {
                    [self removeFromSuperview];
                }
                self.block();
            }];
            
        }
            
            break;
        case ADAnimationTypeZoom:
        {
            [UIView animateWithDuration:1 animations:^{
                CGAffineTransform newTransform = CGAffineTransformMakeScale(1.4,1.4);
                [self setTransform:newTransform];
                [self setAlpha:0];
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                self.block();
            }];
        }
            break;
        default:
        {
            [UIView animateWithDuration:0.25 animations:^{
                self.alpha = 0.0f;
            } completion:^(BOOL finished) {
                if (self.superview) {
                    [self removeFromSuperview];
                }
                self.block();
            }];
            
        }
            break;
    }
}
#pragma mark - show detail page
/**
 *  deal show detail
 */
- (void)showDetailAction {
    NSLog(@"show Detail");
    
    [self closeAction];
}
#pragma mark - dealloc
//remove observer
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end