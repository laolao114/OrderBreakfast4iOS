//
//  LCHUD.m
//  LCModularization
//
//  Created by J on 2017/3/1.
//  Copyright © 2017年 GZLC. All rights reserved.
//

#import "LCHUD.h"
#import "MBProgressHUD.h"

// 显示的 HUD 类型
typedef NS_ENUM (NSInteger, LCHUDType) {
    LCHUDTypeTips = 0,      // 纯文字
    LCHUDTypeProcessing,    // 处理中
    LCHUDTypeIcon           // 自定义图标
};

// 提示文本类型
typedef NS_ENUM (NSInteger, LCHUDTextType) {
    LCHUDTextTypeNormal = 0,     // 单行
    LCHUDTextTypeDetails         // 多行
};

@interface LCHUD ()

@property (strong, nonatomic) MBProgressHUD *hud;

@end

@implementation LCHUD

+ (LCHUD *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        [sharedInstance configDefaultData];
    });
    return sharedInstance;
}

// 设置默认值
- (void)configDefaultData {
    _bgColor = [UIColor colorWithRGB:0x000000 alpha:0.8];
    _contentColor = [UIColor whiteColor];
    _labelTxtColor = [UIColor whiteColor];
    _labelTxtFont = [UIFont systemFontOfSize:15];
    _detailsLabelTxtColor = [UIColor whiteColor];
    _detailsLabelTxtFont = [UIFont systemFontOfSize:14];
    _margin = 30.0;
    _delayTime = 1.5;
    _errorImgName = @"lc_lib_hud_error";
    _successImgName = @"lc_lib_hud_success";
}

#pragma mark - getter
- (void)helperHudToTarget:(UIView *)target type:(LCHUDType)type {
    [[self class] sharedInstance];
    [self hide];
    
    if (target == nil) {
        target = [UIApplication sharedApplication].keyWindow;
    }
    
    _hud = [MBProgressHUD showHUDAddedTo:target animated:YES];
    _hud.margin = _margin;
    // 隐藏时候从父控件中移除
    _hud.removeFromSuperViewOnHide = YES;
    // 颜色
    _hud.bezelView.color = _bgColor;
    
    // 纯文字提示
    if (type == LCHUDTypeTips) {
        _hud.mode = MBProgressHUDModeText;
    }
    else if (type == LCHUDTypeIcon) {
        _hud.mode = MBProgressHUDModeCustomView;
    }
}

#pragma mark - 纯文字提示

/**
 纯文字提示总入口
 
 @param msg 提示文字
 @param delay 多少秒后自动消息，如果为 0 或者小于0 ，则一直显示
 @param textType 单行文字或多行
 @param target 显示的目标，如果为 nil 则显示在 window
 */
- (void)showMsg:(NSString *)msg delay:(NSTimeInterval)delay textType:(LCHUDTextType)textType target:(UIView *)target {
    [self helperHudToTarget:target type:LCHUDTypeTips];
    [self setLabelText:msg type:textType];
    
    // delay秒之后再消失
    if (delay > 0) {
        [_hud hideAnimated:YES afterDelay:delay];
    }
}

// 显示单行提示，需要手动隐藏
+ (void)showMsg:(NSString *)msg target:(UIView *)target {
    [[[self class] sharedInstance] showMsg:msg delay:0 textType:LCHUDTextTypeNormal target:target];
}

// 显示单行提示，会自动消失
- (void)showDelayMsg:(NSString *)msg target:(UIView *)target {
    [self showMsg:msg delay:_delayTime textType:LCHUDTextTypeNormal target:target];
}
+ (void)showDelayMsg:(NSString *)msg target:(UIView *)target {
    [[[self class] sharedInstance] showDelayMsg:msg target:target];
}

// 显示多行提示，需要手动隐藏
+ (void)showDetailsMsg:(NSString *)msg target:(UIView *)target {
    [[[self class] sharedInstance] showMsg:msg delay:0 textType:LCHUDTextTypeDetails target:target];
}

// 显示多行提示，会自动消失
- (void)showDelayDetailsMsg:(NSString *)msg target:(UIView *)target {
    [self showMsg:msg delay:_delayTime textType:LCHUDTextTypeDetails target:target];
}
+ (void)showDelayDetailsMsg:(NSString *)msg target:(UIView *)target {
    [[[self class] sharedInstance] showDelayDetailsMsg:msg target:target];
}

#pragma mark - 显示带图标的提示
/**
 带图标的提示总入口
 
 @param msg 提示文字
 @param delay 多少秒后自动消息，如果为 0 或者小于0 ，则一直显示
 @param textType 单行文字或多行
 @param target 显示的目标，如果为 nil 则显示在 window
 */
- (void)showMsg:(NSString *)msg iconName:(NSString *)iconName delay:(NSTimeInterval)delay textType:(LCHUDTextType)textType target:(UIView *)target {
    [self helperHudToTarget:target type:LCHUDTypeIcon];
    
    _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    
    [self setLabelText:msg type:textType];
    
    // delay秒之后再消失
    if (delay > 0) {
        [_hud hideAnimated:YES afterDelay:delay];
    }
}

// 显示单行错误提示，需要手动隐藏
- (void)showError:(NSString *)msg target:(UIView *)target {
    [self showMsg:msg iconName:_errorImgName delay:0 textType:LCHUDTextTypeNormal target:target];
}
+ (void)showError:(NSString *)msg target:(UIView *)target {
    [[[self class] sharedInstance] showError:msg target:target];
}

// 显示单行错误提示，自动消失
- (void)showDelayError:(NSString *)msg target:(UIView *)target {
    [self showMsg:msg iconName:_errorImgName delay:_delayTime textType:LCHUDTextTypeNormal target:target];
}
+ (void)showDelayError:(NSString *)msg target:(UIView *)target {
    [[[self class] sharedInstance] showDelayError:msg target:target];
}

// 显示多行错误提示，需要手动隐藏
- (void)showDetailsError:(NSString *)msg target:(UIView *)target {
    [self showMsg:msg iconName:_errorImgName delay:0 textType:LCHUDTextTypeDetails target:target];
}
+ (void)showDetailsError:(NSString *)msg target:(UIView *)target {
    [[[self class] sharedInstance] showDetailsError:msg target:target];
}

// 显示多行错误提示，自动消失
- (void)showDelayDetailsError:(NSString *)msg target:(UIView *)target {
    [self showMsg:msg iconName:_errorImgName delay:_delayTime textType:LCHUDTextTypeDetails target:target];
}
+ (void)showDelayDetailsError:(NSString *)msg target:(UIView *)target {
    [[[self class] sharedInstance] showDelayDetailsError:msg target:target];
}

// 显示单行成功提示，需要手动隐藏
- (void)showSuccess:(NSString *)msg target:(UIView *)target {
    [self showMsg:msg iconName:_successImgName delay:0 textType:LCHUDTextTypeNormal target:target];
}
+ (void)showSuccess:(NSString *)msg target:(UIView *)target {
    [[[self class] sharedInstance] showSuccess:msg target:target];
}

// 显示单行成功提示，自动消失
- (void)showDelaySuccess:(NSString *)msg target:(UIView *)target {
    [self showMsg:msg iconName:_successImgName delay:_delayTime textType:LCHUDTextTypeNormal target:target];
}
+ (void)showDelaySuccess:(NSString *)msg target:(UIView *)target {
    [[[self class] sharedInstance] showDelaySuccess:msg target:target];
}

// 显示多行成功提示，需要手动隐藏
- (void)showDetailsSuccess:(NSString *)msg target:(UIView *)target {
    [self showMsg:msg iconName:_successImgName delay:0 textType:LCHUDTextTypeDetails target:target];
}
+ (void)showDetailsSuccess:(NSString *)msg target:(UIView *)target {
    [[[self class] sharedInstance] showDetailsSuccess:msg target:target];
}

// 显示多行成功提示，自动消失
- (void)showDelayDetailsSuccess:(NSString *)msg target:(UIView *)target {
    [self showMsg:msg iconName:_successImgName delay:_delayTime textType:LCHUDTextTypeDetails target:target];
}
+ (void)showDelayDetailsSuccess:(NSString *)msg target:(UIView *)target {
    [[[self class] sharedInstance] showDelayDetailsSuccess:msg target:target];
}

#pragma mark - 显示处理中的提示
/**
 处理中的提示总入口，需要手动隐藏
 
 @param msg 提示文字
 @param textType 单行文字或多行
 @param target 显示的目标，如果为 nil 则显示在 window
 */
- (void)showProcessing:(NSString *)msg textType:(LCHUDTextType)textType target:(UIView *)target {
    [self helperHudToTarget:target type:LCHUDTypeProcessing];
    _hud.contentColor = _contentColor;
    [self setLabelText:msg type:textType];
}

// 显示单行处理中提示
+ (void)showProcessing:(NSString *)msg target:(UIView *)target {
    [[[self class] sharedInstance] showProcessing:msg textType:LCHUDTextTypeNormal target:target];
}

// 显示多行处理中提示
+ (void)showDetailsProcessing:(NSString *)msg target:(UIView *)target {
    [[[self class] sharedInstance] showProcessing:msg textType:LCHUDTextTypeDetails target:target];
}

#pragma mark - 隐藏
- (void)hide {
    [_hud hideAnimated:YES];
}
+ (void)hide {
    [[[self class] sharedInstance] hide];
}

#pragma mark - 设置文本
- (void)setLabelText:(NSString *)txt type:(LCHUDTextType)type {
    if (type == LCHUDTextTypeNormal) {
        _hud.label.text = txt;
        _hud.label.textColor = _labelTxtColor;
        _hud.label.font = _labelTxtFont;
    }
    else {
        _hud.detailsLabel.text = txt;
        _hud.detailsLabel.textColor = _detailsLabelTxtColor;
        _hud.detailsLabel.font = _detailsLabelTxtFont;
    }
}

@end
