//
//  LCLibConstants.h
//
//  LCModularization
//  Created by yaoyunheng on 2017/3/27.
//  Copyright © 2017年 yaoyunheng. All rights reserved.
//
//  定义项目的常量

#import <UIKit/UIKit.h>

//#ifndef LCLibConstants_h
//#define LCLibConstants_h
//
//#endif /* LCLibConstants_h */

#pragma mark - 国际化
#define LCLocalString(key, comment) NSLocalizedStringFromTable(key, @"LCLib", comment)

// 日志输出
#ifdef DEBUG
#define LCLog(...) NSLog(__VA_ARGS__)
#else
#define LCLog(...)
#endif

#pragma mark - 屏幕相关
// 屏幕大小
#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]
// 屏幕宽度
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
// 屏幕高度
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
// 屏幕缩放
#define SCREEN_SCALE [[UIScreen mainScreen] scale]
// 1 像素的值，如果直接用 0.5 ，在屏幕缩放是 2 倍以上的屏幕显示的按钮边框线条会粗细不一
#define ONE_PX (1.0 / SCREEN_SCALE)

#define IS_IPHONE_5_SCREEN ([UIScreen mainScreen].bounds.size.height == 568)

#pragma mark - 常用对象
// UIControlState All
#define UIControlStateAll UIControlStateNormal & UIControlStateSelected & UIControlStateHighlighted

#define WEAKSELF typeof(self) __weak weakSelf = self;
// 系统版本
#define IOS_VERSIONS [[[UIDevice currentDevice] systemVersion] floatValue]
// window 对象
#define APP_WINDOW [UIApplication sharedApplication].keyWindow

#pragma mark- 色值
// 主色
#define COLOR_PRIMARY UIColorHex(0xffffff)
// 黑色字体1
#define COLOR_TEXT_BLACK  UIColorHex(0x333333)
// 浅黑色字体
#define COLOR_TEXT_LIGHT_BLACK  UIColorHex(0x666666)
// 灰色字体
#define COLOR_TEXT_GRAY UIColorHex(0x999999)
// 背景灰色
#define COLOR_BACKGROUND_GRAY UIColorHex(0xf8f8f8)
// 分隔线条颜色
#define COLOR_LINE_SEPARATE UIColorHex(0xe7e7e7)
// 下滑线条颜色
#define COLOR_LINE_UNDER UIColorHex(0xe7e7e7)
// 蓝色
#define COLOR_BLUE UIColorHex(0x2a7adb)
// 蓝色点击
#define COLOR_BLUE_HIGHLIGHTED UIColorHex(0x009ad4)
// 蓝色不可点击
#define COLOR_BLUE_DISABLED UIColorHex(0x75b5d9)
// 文字按钮蓝色点击
#define COLOR_BUTTON_BLUE_HIGHLIGHTED UIColorHex(0xa4c8dc)
// 白色按钮点击
#define COLOR_BUTTON_WHITE_HIGHLIGHTED UIColorHex(0xf9f9f9)
// 白色背景点击
#define COLOR_VIEW_WHITE_SELECTED UIColorHex(0xf9f9f9)
// 红色
#define COLOR_RED UIColorHex(0xfc0d1b)
// 橘色
#define COLOR_ORANGE UIColorHex(0xF4995B)
// 绿色
#define COLOR_GREEN UIColorHex(0x79bc79)

#pragma mark - 默认图
// 封面图
#define IMG_DEFAULT_IMG [UIImage imageWithColor:[UIColor colorWithRGB:0xcccccc]]
// 头像
#define IMG_DEFAULT_AVATAR [UIImage imageNamed:@"avatar"]

#pragma mark - 分享
// 标题
#define SHARE_DEFAULT_TITLE @"分享标题"
// 描述
#define SHARE_DEFAULT_TEXT @"分享描述"
// 链接
#define SHARE_DEFAULT_LINK @"https://www.baidu.com"
// 图片
#define SHARE_DEFAULT_IMG [UIImage imageNamed:@"share_default"]

#pragma mark - NSNotificationCenter 通知定义
// 支付宝支付成功回调
UIKIT_EXTERN NSString *const LCNotifyAliPaySuccess;
// 微信支付成功回调
UIKIT_EXTERN NSString *const LCNotifyWechatPaySuccess;
// 列表刷新通知
UIKIT_EXTERN NSString *const LCNofityListRefresh;   
#pragma mark - login 登录相关
/*
 *  Login
 *
 */
UIKIT_EXTERN NSUInteger const kMaxMobileNumber;
UIKIT_EXTERN NSUInteger const kMaxPSWNumber;
// 登录相关输入框高度
static const CGFloat kLoginTextFieldHeight = 48;
static const CGFloat kLoginButtonHeight = 39;

typedef NS_ENUM(NSInteger, OrderPayType) {
    OrderPayTypeReserve = 1,            // 预存
    OrderPayTypePayImmediately,         // 现结
    OrderPayTypeMonthly                 // 月结
};



