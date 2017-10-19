//
//  LCNetworkHelper.m
//
//  Created by yaoyunheng on 2016/10/17.
//  Copyright © 2016年 GZLC. All rights reserved.
//

#import "LCNetworkHelper.h"

static NSString *const App_Key = @"1344104881";
static NSString *const App_Secret_Key = @"3671c1b0d69d5285f0db8dea779fb75e";

@interface LCNetworkHelper ()

// 记录上一次发送时的时间戳
@property (nonatomic) NSTimeInterval historyTime;

@end

@implementation LCNetworkHelper

+ (LCNetworkHelper *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSString *)baseUrl {
    return BASE_URL;
}

#pragma mark - 返回时间戳
- (NSTimeInterval)getRequestTime {
    NSTimeInterval current = [[NSDate date] timeIntervalSince1970];
    
    if (_requestTime == 0) {
        _requestTime = current;
    } else{
        //如果用户的本地时间不准，会根据服务器返回的时间戳去修正
        _requestTime += current - _historyTime;
    }
    
    _historyTime = current;
    
    return _requestTime;
}

- (NSTimeInterval)requestTimeoutInterval {
    return 20;
}

#pragma mark - 请求头
- (NSDictionary *)createRequestHeader {
    NSInteger interval = (NSInteger)[self getRequestTime];
    NSString *oriStr = [App_Key stringByAppendingFormat:@"%ld%@", (long)interval, App_Secret_Key];
    NSString *time = [NSString stringWithFormat:@"%ld",(long)interval];
    return @{
                 @"LC-Appkey": App_Key,
                 @"LC-Timestamp": time,
                 @"LC-Sign": [oriStr md5String],
                 @"LC-ClientVersion": [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"],
                 @"LC-ClientBrand": @"0",
                 @"LC-ClientOSVersion": @([[[UIDevice currentDevice] systemVersion] floatValue]).stringValue,
                 @"LC-Session": [LCAccount sharedInstance].sessionId ? : @""
             };
}

@end
