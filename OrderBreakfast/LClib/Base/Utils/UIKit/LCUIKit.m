//
//  LCUIKit.m
//  LCModularization
//
//  Created by J on 2017/2/15.
//  Copyright © 2017年 GZLC. All rights reserved.
//

#import "LCUIKit.h"

@implementation LCUIKit

#pragma mark - NavigationBar 左右按钮
/**
 没有文字

 @param imgName 正常状态的图标名称
 @param highlightImgName 高亮状态的图标名称，没有就传 nil 或 @""
 @param position 0：左 1：右
 @return 生成的按钮
 */
+ (UIButton *)createNavigationItemBtnWithImgName:(NSString *)imgName highlightImgName:(NSString *)highlightImgName position:(NSUInteger)position {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, -16, 0, 16);
    if (position != 0) {
        insets = UIEdgeInsetsMake(0, 16, 0, -16);
    }
    btn.imageEdgeInsets = insets;
    // 正常状态
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    // 高亮状态
    if (highlightImgName.length > 0) {
        [btn setImage:[UIImage imageNamed:highlightImgName] forState:UIControlStateHighlighted];
    }
    
    return btn;
}

/**
 文字 + 图标 或 纯文字
 
 @param imgName 正常状态的图标名称
 @param highlightImgName 高亮状态的图标名称
 @param position 0：左 1：右
 @param title 文字
 @return 生成的按钮
 */
+ (UIButton *)createNavigationItemBtnWithImgName:(NSString *)imgName highlightImgName:(NSString *)highlightImgName title:(NSString *)title position:(NSUInteger)position {
    UIImage *img = [UIImage imageNamed:imgName];
    UIImage *highlightImg = [UIImage imageNamed:highlightImgName];
    CGFloat width = 0;
    CGFloat height = 44;
    
    //有图标
    if (img) {
        width = img.size.width;
    }
    
    CGFloat fontSize = 18.0;
    NSInteger count = title.length;
    //有文字
    if (count > 0) {
        width = width + count * fontSize + 1;
    }
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    // 正常状态
    if (img) {
        [btn setImage:img forState:UIControlStateNormal];
    }
    // 高亮状态
    if (highlightImg) {
        [btn setImage:highlightImg forState:UIControlStateHighlighted];
    }
    
    // 非左边`
    if (position != 0) {
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 6, 0, -6);
    } else {
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 6);
    }
    
    [btn setTitle:title forState:UIControlStateNormal];
    btn.adjustsImageWhenHighlighted = NO;
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return btn;
}

+ (UIButton *)createNavigationItemBtnWithImgName:(NSString *)imgName highlightImgName:(NSString *)highlightImgName title:(NSString *)title position:(NSUInteger)position fontSize:(CGFloat)fontSize {
    UIImage *img = [UIImage imageNamed:imgName];
    UIImage *highlightImg = [UIImage imageNamed:highlightImgName];
    CGFloat width = 0;
    CGFloat height = 44;
    
    //有图标
    if (img) {
        width = img.size.width;
    }
    
    NSInteger count = title.length;
    //有文字
    if (count > 0) {
        width = width + count * fontSize + 14;
    }
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    // 正常状态
    if (img) {
        [btn setImage:img forState:UIControlStateNormal];
    }
    // 高亮状态
    if (highlightImg) {
        [btn setImage:highlightImg forState:UIControlStateHighlighted];
    }
    
    // 非左边`
    if (position != 0) {
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 6, 0, -6);
    } else {
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 6);
    }
    
    [btn setTitle:title forState:UIControlStateNormal];
    btn.adjustsImageWhenHighlighted = NO;
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return btn;
}

@end
