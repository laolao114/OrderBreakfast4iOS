//
//  LCHUD.h
//  LCModularization
//
//  Created by J on 2017/3/1.
//  Copyright © 2017年 GZLC. All rights reserved.
//
//  MBProgressHUD 助手类，使用该类时，只会同时存在一个 HUD，当显示下一个 HUD 时，之前的会被隐藏

#import <Foundation/Foundation.h>

@interface LCHUD : NSObject

// 背景色
@property (strong, nonatomic) UIColor *bgColor;
// 内容颜色
@property (strong, nonatomic) UIColor *contentColor;
// 单行提示文字颜色
@property (strong, nonatomic) UIColor *labelTxtColor;
// 单行提示文字字体
@property (strong, nonatomic) UIFont *labelTxtFont;
// 多行提示文字颜色
@property (strong, nonatomic) UIColor *detailsLabelTxtColor;
// 多行提示文字字体
@property (strong, nonatomic) UIFont *detailsLabelTxtFont;
// 边距
@property (nonatomic) CGFloat margin;
// 显示时间
@property (nonatomic) NSTimeInterval delayTime;
// 错误图标名字
@property (strong, nonatomic) NSString *errorImgName;
// 成功图标名字
@property (strong, nonatomic) NSString *successImgName;

+ (LCHUD *)sharedInstance;

/**
 显示单行提示，需要手动隐藏
 
 @param msg 提示文字
 @param target 显示的目标，如果为 nil 则显示在 window
 */
+ (void)showMsg:(NSString *)msg target:(UIView *)target;
// 显示单行提示，会自动消失
+ (void)showDelayMsg:(NSString *)msg target:(UIView *)target;
// 显示多行提示，需要手动隐藏
+ (void)showDetailsMsg:(NSString *)msg target:(UIView *)target;
// 显示多行提示，会自动消失
+ (void)showDelayDetailsMsg:(NSString *)msg target:(UIView *)target;

// 显示单行错误提示，需要手动隐藏
+ (void)showError:(NSString *)msg target:(UIView *)target;
// 显示单行错误提示，自动消失
+ (void)showDelayError:(NSString *)msg target:(UIView *)target;
// 显示多行错误提示，需要手动隐藏
+ (void)showDetailsError:(NSString *)msg target:(UIView *)target;
// 显示多行错误提示，自动消失
+ (void)showDelayDetailsError:(NSString *)msg target:(UIView *)target;

// 显示单行成功提示，需要手动隐藏
+ (void)showSuccess:(NSString *)msg target:(UIView *)target;
// 显示单行成功提示，自动消失
+ (void)showDelaySuccess:(NSString *)msg target:(UIView *)target;
// 显示多行成功提示，需要手动隐藏
+ (void)showDetailsSuccess:(NSString *)msg target:(UIView *)target;
// 显示多行成功提示，自动消失
+ (void)showDelayDetailsSuccess:(NSString *)msg target:(UIView *)target;

// 显示单行处理中提示，需要手动隐藏
+ (void)showProcessing:(NSString *)msg target:(UIView *)target;

// 显示多行处理中提示，需要手动隐藏
+ (void)showDetailsProcessing:(NSString *)msg target:(UIView *)target;

// 隐藏 HUD
+ (void)hide;


@end
