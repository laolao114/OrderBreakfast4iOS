//
//  LCBaseRequest.m
//
//  Created by yaoyunheng on 2016/10/17.
//  Copyright © 2016年 GZLC. All rights reserved.
//

#import "LCBaseRequest.h"

@implementation LCBaseRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        _baseUrl = [LCNetworkHelper sharedInstance].baseUrl;
    }
    return self;
}

- (NSString *)requestUrl {
    //如果没有设置请求服务器的地址就用 LCNetworkHelper 的默认设置
    if (_requestUrl.length == 0) {
        _requestUrl = _baseUrl;
    }
    
    return _requestUrl;
}

- (LCBaseRequestType)requestType {
    if (_requestType == 0) {
        _requestType = LCBaseRequestTypePOST;
    }
    return _requestType;
}

- (NSString *)modelName {
    if (!_modelName) {
        _modelName = NETWORK_BASE_MODEL_NAME;
    }
    return _modelName;
}

//- (id)responseJSONObject {
//    return [_responseJSONObject jsonStringEncoded];
//}

- (void)clearCompletionBlock {
    // nil out to break the retain cycle.
    _successBlock = nil;
    _failureBlock = nil;
}

@end
