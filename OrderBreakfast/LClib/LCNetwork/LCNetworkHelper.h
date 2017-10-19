//
//  LCNetworkHelper.h
//
//  Created by yaoyunheng on 2016/10/17.
//  Copyright © 2016年 GZLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark- 网络相关
//#define REALM_NAME_URL  @"api.chubankuai.com" //正式
#define REALM_NAME_URL  @"www.chubankuai.6cheng.com.cn" //测试
#define BASE_URL [NSString stringWithFormat:@"http://%@/index.php?service=", REALM_NAME_URL]

// 无网络连接
static NSInteger const NO_NETWORK_ERROR_CODE = 0;
// 请求成功代码
static NSInteger REQUEST_SUCCESS_CODE  = 200;
// 时间戳错误代码
static NSInteger TIME_STAMP_ERROR_CODE = 300;
// 请求的 api 不存在
static NSInteger API_NULL_ERROR_CODE   = 302;
// sessionId 非法代码
static NSInteger SESSION_ID_ERROR_CODE = 303;
//基本的数据模型类
static NSString *NETWORK_BASE_MODEL_NAME = @"LCBaseModel";

//返回的数据的一些关键 key
static NSString *RESPONSE_CODE_KEY = @"ret";
static NSString *RESPONSE_TIME_STAMP_KEY = @"timestamp";
static NSString *RESPONSE_MSG = @"msg";
static NSString *RESPONSE_DATA_KEY = @"data";

//请求成功后返回数据模型数组
typedef void(^LCNetworkSuccessBlock)(id responseObject);
//请求失败后的回调
typedef void(^LCNetworkFailureBlock)(NSInteger errCode, NSString *errDescription);

@interface LCNetworkHelper : NSObject

// 默认服务器地址
@property (copy, nonatomic) NSString *baseUrl;
// 发送请求用的时间戳
@property (nonatomic) NSTimeInterval requestTime;

+ (instancetype)sharedInstance;

/**
 *  请求头
 *
 *  @return 请求头字典
 */
- (NSDictionary *)createRequestHeader;

/**
 * 获取请求时间
 */
- (NSTimeInterval)getRequestTime;

// 请求超时时间
- (NSTimeInterval)requestTimeoutInterval;

@end
