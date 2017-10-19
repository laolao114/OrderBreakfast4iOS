//
//  LCNotificationHelper.m
//  Futures
//
//  Created by yaoyunheng on 2017/3/27.
//  Copyright © 2017年 yaoyunheng. All rights reserved.
//

#import "LCNotificationHelper.h"
#import "JPUSHService.h"
//#import "OrderDetailController.h"
#import "NSObject+LCAdd.h"

@implementation LCNotificationHelper

+ (void)handleNotifyInfo:(NSDictionary *)info {
    // [info[@"c_type"] integerValue] c_type：
    
    NSInteger inApp = [info[@"inApp"] integerValue];
    // 在应用内跳转，已经在应用内不跳 0：app内；1：不在app内；
    if (inApp == 1) {
        return;
    }
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:info];
    NSInteger c_type = [dic[@"c_type"] integerValue];
//    NSString *message = info[@"data"][@"message"];
    NSString *out_id = dic[@"out_id"];
    // 1-线上支付  2-等待收货 3-联系客服收款  4-月结账户扣款 5-预存账户扣款
    switch (c_type) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:{
//            OrderDetailController *detailController = [[OrderDetailController alloc]init];
//            detailController.o_id = out_id;
//            [[self visibleViewController].navigationController pushViewController:detailController animated:YES];
        }
            break;
        default:
            break;
    }
}

+ (void)handleURLQuery:(NSString *)query {
    if (query.length > 0) {
        NSArray *paramArray = [query componentsSeparatedByString:@"&"];
        NSString *type      = [paramArray[0] stringByReplacingOccurrencesOfString:@"type=" withString:@""];
        switch ([type integerValue]) {
            case 1: {
                
            }
                break;
                
            default:
                break;
        }
    }
}

// 清空应用推送数
+ (void)resetBadgeNum {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService setBadge:0];
    [LCAccount sharedInstance].unreadCount = 0;
}

@end
