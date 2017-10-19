//
//  UIViewController+LCAdd.h
//  LCModularization
//
//  Created by J on 2017/2/14.
//  Copyright © 2017年 GZLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LCAdd)

/**
 添加 NavigationBar 左右按钮，可以为纯图标或纯文字或文字 + 图标
 
 @param imgName 正常状态的图标名称
 @param highlightImgName 高亮状态的图标名称，没有就传 nil 或 @""
 @param title 文字
 @param selector 回调方法
 @return 生成的按钮
 */
- (UIButton *)createLeftNavigationItemBtnWithImgName:(NSString *)imgName highlightImgName:(NSString *)highlightImgName title:(NSString *)title selector:(SEL)selector;
- (UIButton *)createRightNavigationItemBtnWithImgName:(NSString *)imgName highlightImgName:(NSString *)highlightImgName title:(NSString *)title selector:(SEL)selector;
- (UIButton *)createRightNavigationItemBtnWithImgName:(NSString *)imgName highlightImgName:(NSString *)highlightImgName title:(NSString *)title selector:(SEL)selector fontSize:(CGFloat)fontSize;
@end
