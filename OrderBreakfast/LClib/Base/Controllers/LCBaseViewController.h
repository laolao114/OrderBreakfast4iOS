//
//  LCBaseViewController.h
//  LCModularization
//
//  Created by J on 2017/2/14.
//  Copyright © 2017年 GZLC. All rights reserved.
//
//  子页面基础 UIViewController ，不显示 TabBar

#import <UIKit/UIKit.h>

@interface LCBaseViewController : UIViewController


/**
 页面是否需要滚动，默认为 NO
 // 要设置为 YES，在子类的初始化方法里设置
 - (instancetype)init {
     self = [super init];
     if (self) {
         self.viewToScrollView = YES;
     }
     return self;
 }
 */
@property (nonatomic) BOOL viewToScrollView;

/**
 内容容器。无论页面需不需要滚动，都建议用 contView 来代替 self.view
 viewToScrollView 为 NO 时，contView 指向 self.view；
 viewToScrollView 为 YES 时，self.view 包含一个 UIScrollView，UIScrollView 再包含 contView，放到 contView 的内容可滚动
 记得更新最后一个view的bottom与contViewbottom之间的约束
 */
@property (weak, nonatomic) UIView *contView;
// 滚动容器
@property (weak, nonatomic) UIScrollView *scrollView;

// 关闭页面，animate 是否需要动画
- (void)backAction:(BOOL)animate;

@end
