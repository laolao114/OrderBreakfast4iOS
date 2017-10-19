//
//  NSObject+LCAdd.m
//  LCModularization
//
//  Created by J on 2017/2/14.
//  Copyright © 2017年 GZLC. All rights reserved.
//

#import "NSObject+LCAdd.h"

@implementation NSObject (LCAdd)

// 获取当前所显示的 UIViewController
- (UIViewController *)visibleViewController {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [[self class] getVisibleViewControllerFrom:rootViewController];
}
// 从指定的 UIViewController 中获取显示的 UIViewController
- (UIViewController *) getVisibleViewControllerFrom:(UIViewController *) vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self getVisibleViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [self getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
}

@end
