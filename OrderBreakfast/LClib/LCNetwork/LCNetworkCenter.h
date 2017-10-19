//
//  LCNetworkCenter.h
//
//  Created by yaoyunheng on 2016/10/17.
//  Copyright © 2016年 GZLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCBaseRequest.h"
#import "LCBaseModel.h"
#import "AFNetworking.h"

#pragma mark - 网络状态变化通知
// 无网络通知
#define LCNetworkCenterNotificationReachabilityStatusNotReachable @"LCNetworkCenterNotificationReachabilityStatusNotReachable"
// 蜂窝网络通知
#define LCNetworkCenterNotificationReachabilityStatusReachableViaWWAN @"LCNetworkCenterNotificationReachabilityStatusReachableViaWWAN"
// WIFI通知
#define LCNetworkCenterNotificationReachabilityStatusReachableViaWiFi @"LCNetworkCenterNotificationReachabilityStatusReachableViaWiFi"

@interface LCNetworkCenter : NSObject

//当前网络状态
@property (nonatomic) AFNetworkReachabilityStatus reachabilityStatus;

+ (LCNetworkCenter *)sharedInstance;

/**
 *  POST 请求
 *
 *  @param url 请求地址
 *  @param parameters 请求参数
 *
 *  @param successBlock 成功回调
 *  @param failureBlock 失败回调
 */
+ (void)postWithPath:(NSString *)url parameters:(NSDictionary*)parameters success:(LCNetworkSuccessBlock)successBlock failure:(LCNetworkFailureBlock)failureBlock;

/**
 *  GET 请求
 *
 *  @param url 请求地址
 *  @param parameters 请求参数
 *
 *  @param successBlock 成功回调
 *  @param failureBlock 失败回调
 */
+ (void)getWithPath:(NSString *)url parameters:(NSDictionary*)parameters success:(LCNetworkSuccessBlock)successBlock failure:(LCNetworkFailureBlock)failureBlock;

/**
 *  修正时间戳
 *
 *  @param time 时间
 */
+ (void)resetRequestTime:(double)time;

/**
 *  检测网络是否可用
 *
 *  @return 当前是否网络可用
 */
- (BOOL)isNetworkNormal;

@end
