//
//  LCWebViewController.h
//  LCModularization
//
//  Created by yaoyunheng on 2017/3/29.
//  Copyright © 2017年 yaoyunheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCWebProgressView : UIView

@property (nonatomic) float progress;
@property (nonatomic) UIView *progressBarView;
@property (nonatomic) NSTimeInterval barAnimationDuration; // default 0.1
@property (nonatomic) NSTimeInterval fadeAnimationDuration; // default 0.27
@property (nonatomic) NSTimeInterval fadeOutDelay; // default 0.1

- (void)setProgress:(float)progress animated:(BOOL)animated;

@end


extern const float WebInitialProgressValue;
extern const float WebInteractiveProgressValue;
extern const float WebFinalProgressValue;

@interface LCWebViewController : UIViewController

- (instancetype)initWithURLString:(NSString *)URLString;

@property (nonatomic, strong) NSString *theTitle;
@property (nonatomic, weak) id<UIWebViewDelegate> delegate;

@end
