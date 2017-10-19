//
//  MyTabBarViewController.m
//  OrderBreakfast
//
//  Created by old's mac on 2017/7/18.
//  Copyright © 2017年 scnu. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "HomeMainController.h"
#import "OrderMainController.h"
#import "MeMainController.h"

@interface MyTabBarViewController () <UITabBarControllerDelegate> {
    HomeMainController *_homeMainCon;
    OrderMainController *_getOrderMainCon;
    MeMainController *_meMainCon;
}

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    // 改变 tabbar 线条颜色
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, UIColorHex(0x00000020).CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setShadowImage:img];
    [self.tabBar setBackgroundImage:[[UIImage alloc] init]];
    
    _homeMainCon = [[HomeMainController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:_homeMainCon];

    _getOrderMainCon = [[OrderMainController alloc] init];
    UINavigationController *getOrderNav = [[UINavigationController alloc] initWithRootViewController:_getOrderMainCon];
    
    
    _meMainCon = [[MeMainController alloc] init];
    UINavigationController *meNav = [[UINavigationController alloc] initWithRootViewController:_meMainCon];
    
    self.tabBar.translucent = NO;
    self.viewControllers = @[homeNav,
                             getOrderNav,
                             meNav
                             ];
    NSArray *titles = @[@"首页", @"接单", @"我的"];
    NSArray *images = @[@"icon_home", @"icon_order-form", @"icon_me"];
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *item, NSUInteger idx, BOOL *stop) {
        [item setTitle:titles[idx]];
        // 上提2个像素
        [item setTitlePositionAdjustment:UIOffsetMake(0, -2)];
        [item setImage:[UIImage imageNamed:images[idx]]];
        [item setSelectedImage:[UIImage imageNamed:[images[idx] stringByAppendingString:@"_h"]]];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark- tabbar controller delegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    switch ([tabBarController.viewControllers indexOfObject:viewController]) {
        case 0: {
            
        }
            break;
        case 1: {
            
        }
            break;
        case 2: {
            
        }
            break;
        default:
            break;
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    NSInteger index = [tabBarController.viewControllers indexOfObject:viewController];
    switch (index) {
        case 0: {
            return YES;
        }
            break;
        case 1: {
            return YES;
        }
            break;
        case 2: {
            return YES;
        }
            break;
        default:
            break;
    }
    return YES;
}
@end
