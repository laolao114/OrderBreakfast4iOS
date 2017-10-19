//
//  LCBaseRequest.h
//
//  Created by yaoyunheng on 2016/10/17.
//  Copyright © 2016年 GZLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCNetworkHelper.h"

//请求类型
typedef NS_ENUM (NSInteger, LCBaseRequestType) {
    LCBaseRequestTypeGET = 1, //GET
    LCBaseRequestTypePOST //POST
};

@interface LCBaseRequest : NSObject

//服务器地址，如果没有设置就用 LCNetworkHelper 类的默认设置
@property (copy, nonatomic) NSString *baseUrl;
//请求地址
@property (copy, nonatomic) NSString *requestUrl;
//请求类型
@property (nonatomic) LCBaseRequestType requestType;
//请求体
@property (nonatomic, strong) NSDictionary *parameters;
//model名字
@property (copy, nonatomic) NSString *modelName;

//请求成功回调
@property (copy, nonatomic) LCNetworkSuccessBlock successBlock;
//请求失败回调
@property (copy, nonatomic) LCNetworkFailureBlock failureBlock;
//该请求所返回的数据
@property (nonatomic) id responseJSONObject;

/**
 *  清理 Block 防止循环引用
 */
- (void)clearCompletionBlock;

@end
