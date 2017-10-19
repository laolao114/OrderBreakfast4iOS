//
//  AppDelegate.m
//  OrderBreakfast
//
//  Created by old's mac on 2017/7/18.
//  Copyright © 2017年 scnu. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarViewController.h"
#import "IQKeyboardManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)appDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UINavigationBar appearance].barStyle = UIStatusBarStyleLightContent;
    [UINavigationBar appearance].translucent = NO;
    [UINavigationBar appearance].tintColor = COLOR_BLUE;
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18]};
    [UINavigationBar appearance].barTintColor = COLOR_BLUE;
    [UINavigationBar appearance].shadowImage = [UIImage imageWithColor:[UIColor whiteColor]];
    
    // tabbar stytle
    [UITabBar appearance].tintColor = COLOR_BLUE;
    [UITabBar appearance].barTintColor = [UIColor whiteColor];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self switchRoot];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Switch Root Or Login
- (void)switchRoot {
    MyTabBarViewController *tabBarCon = [MyTabBarViewController new];
    self.window.rootViewController = tabBarCon;
}

- (void)switchLogin {
//    LoginViewController *login = [LoginViewController new];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
//    nav.navigationBar.barStyle = UIStatusBarStyleLightContent;
//    [[self visibleViewController] presentViewController:nav animated:YES completion:^{
//        
//    }];
}

@end
