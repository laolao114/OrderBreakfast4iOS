//
//  UIViewController+LCAdd.m
//  LCModularization
//
//  Created by J on 2017/2/14.
//  Copyright © 2017年 GZLC. All rights reserved.
//

#import "UIViewController+LCAdd.h"

@implementation UIViewController (LCAdd)

/**
 添加 NavigationBar 左右按钮，可以为纯图标或纯文字或文字 + 图标

 @param imgName 正常状态的图标名称
 @param highlightImgName 高亮状态的图标名称，没有就传 nil 或 @""
 @param title 文字
 @param position position 0：左 1：右
 @param selector 回调方法
 @return 生成的按钮
 */
- (UIButton *)createNavigationItemBtnWithImgName:(NSString *)imgName highlightImgName:(NSString *)highlightImgName title:(NSString *)title position:(NSUInteger)position selector:(SEL)selector {
    UIButton *btn;
    
    // 如果有文字
    if (title.length > 0) {
        btn = [LCUIKit createNavigationItemBtnWithImgName:imgName highlightImgName:highlightImgName title:title position:position];
    } else {
        btn = [LCUIKit createNavigationItemBtnWithImgName:imgName highlightImgName:highlightImgName position:position];
    }
    
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    if (position != 0) {
        self.navigationItem.rightBarButtonItem = btnItem;
    } else {
        self.navigationItem.leftBarButtonItem = btnItem;
    }
    
    return btn;
}

- (UIButton *)createNavigationItemBtnWithImgName:(NSString *)imgName highlightImgName:(NSString *)highlightImgName title:(NSString *)title position:(NSUInteger)position selector:(SEL)selector fontSize:(CGFloat)fontSize {
    UIButton *btn;
    
    // 如果有文字
    if (title.length > 0) {
        btn = [LCUIKit createNavigationItemBtnWithImgName:imgName highlightImgName:highlightImgName title:title position:position fontSize:fontSize];
    } else {
        btn = [LCUIKit createNavigationItemBtnWithImgName:imgName highlightImgName:highlightImgName position:position];
    }
    
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    if (position != 0) {
        self.navigationItem.rightBarButtonItem = btnItem;
    } else {
        self.navigationItem.leftBarButtonItem = btnItem;
    }
    
    return btn;
}

// 添加 NavigationBar 左按钮
- (UIButton *)createLeftNavigationItemBtnWithImgName:(NSString *)imgName highlightImgName:(NSString *)highlightImgName title:(NSString *)title selector:(SEL)selector {
    return [self createNavigationItemBtnWithImgName:imgName highlightImgName:highlightImgName title:title position:0 selector:selector];
}

// 添加 NavigationBar 右按钮
- (UIButton *)createRightNavigationItemBtnWithImgName:(NSString *)imgName highlightImgName:(NSString *)highlightImgName title:(NSString *)title selector:(SEL)selector {
    return [self createNavigationItemBtnWithImgName:imgName highlightImgName:highlightImgName title:title position:1 selector:selector];
}
// 添加 NavigationBar 右按钮
- (UIButton *)createRightNavigationItemBtnWithImgName:(NSString *)imgName highlightImgName:(NSString *)highlightImgName title:(NSString *)title selector:(SEL)selector fontSize:(CGFloat)fontSize {
    return [self createNavigationItemBtnWithImgName:imgName highlightImgName:highlightImgName title:title position:1 selector:selector fontSize:fontSize];
}

@end
