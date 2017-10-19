//
//  LCNotificationHelper.h
//  Futures
//
//  Created by yaoyunheng on 2017/3/27.
//  Copyright © 2017年 yaoyunheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCNotificationHelper : NSObject

+ (void)handleNotifyInfo:(NSDictionary *)info;
+ (void)handleURLQuery:(NSString *)query;
+ (void)resetBadgeNum;

@end
