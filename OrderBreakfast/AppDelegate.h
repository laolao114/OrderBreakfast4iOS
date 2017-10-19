//
//  AppDelegate.h
//  OrderBreakfast
//
//  Created by old's mac on 2017/7/18.
//  Copyright © 2017年 scnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)appDelegate;
- (void)switchRoot;
- (void)switchLogin;

@end

