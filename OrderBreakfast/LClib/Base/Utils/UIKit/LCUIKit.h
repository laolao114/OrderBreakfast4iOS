//
//  LCUIKit.h
//  LCModularization
//
//  Created by J on 2017/2/15.
//  Copyright © 2017年 GZLC. All rights reserved.
//
//  生成公用的一些 UIView （或其子类）

#import <Foundation/Foundation.h>

@interface LCUIKit : NSObject

#pragma mark - NavigationBar 左右按钮
/**
 没有文字
 
 @param imgName 正常状态的图标名称
 @param highlightImgName 高亮状态的图标名称，没有就传 nil 或 @""
 @param position 0：左 1：右
 @return 生成的按钮
 */
+ (UIButton *)createNavigationItemBtnWithImgName:(NSString *)imgName highlightImgName:(NSString *)highlightImgName position:(NSUInteger)position;

/**
 文字 + 图标 或 纯文字
 
 @param imgName 正常状态的图标名称
 @param highlightImgName 高亮状态的图标名称
 @param position 0：左 1：右
 @param title 文字
 @return 生成的按钮
 */
+ (UIButton *)createNavigationItemBtnWithImgName:(NSString *)imgName highlightImgName:(NSString *)highlightImgName title:(NSString *)title position:(NSUInteger)position;
// 多了一个字体大小的参数
+ (UIButton *)createNavigationItemBtnWithImgName:(NSString *)imgName highlightImgName:(NSString *)highlightImgName title:(NSString *)title position:(NSUInteger)position fontSize:(CGFloat)fontSize;

@end
