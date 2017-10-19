//
//  LCNetworkCenter.m
//
//  Created by yaoyunheng on 2016/10/17.
//  Copyright © 2016年 GZLC. All rights reserved.
//

#import "LCNetworkCenter.h"
#import "AppDelegate.h"

@interface LCNetworkCenter ()

@end

static NSString *ossEndPoint = @"oss-cn-shenzhen.aliyuncs.com";
static NSString *ossBucket = @"chubankuai";

@implementation LCNetworkCenter

+ (LCNetworkCenter *)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
        [_sharedInstance startMonitoring];
    });
    return _sharedInstance;
}

#pragma mark - 生成请求对象
- (void)requestWithPath:(NSString*)url parameters:(NSDictionary*)parameters andRequestType:(LCBaseRequestType)requestType success:(LCNetworkSuccessBlock)successBlock failure:(LCNetworkFailureBlock)failureBlock {
    
    LCBaseRequest *baseRequest = [LCBaseRequest new];
    baseRequest.requestUrl   = url;
    baseRequest.parameters   = parameters;
    baseRequest.requestType  = requestType;
    baseRequest.successBlock = successBlock;
    baseRequest.failureBlock = failureBlock;
    
    [self processRequest:baseRequest];
}

#pragma mark - POST 请求
- (void)postWithPath:(NSString *)url parameters:(NSDictionary *)parameters success:(LCNetworkSuccessBlock)successBlock failure:(LCNetworkFailureBlock)failureBlock {
    [self requestWithPath:url parameters:parameters andRequestType:LCBaseRequestTypePOST success:successBlock failure:failureBlock];
}

+ (void)postWithPath:(NSString *)url parameters:(NSDictionary *)parameters success:(LCNetworkSuccessBlock)successBlock failure:(LCNetworkFailureBlock)failureBlock {
    [[LCNetworkCenter sharedInstance] postWithPath:url parameters:parameters success:successBlock failure:failureBlock];
}

#pragma mark - GET 请求
- (void)getWithPath:(NSString *)url parameters:(NSDictionary*)parameters success:(LCNetworkSuccessBlock)successBlock failure:(LCNetworkFailureBlock)failureBlock {
    [self requestWithPath:url parameters:parameters andRequestType:LCBaseRequestTypeGET success:successBlock failure:failureBlock];
}

+ (void)getWithPath:(NSString *)url parameters:(NSDictionary*)parameters success:(LCNetworkSuccessBlock)successBlock failure:(LCNetworkFailureBlock)failureBlock {
    [[LCNetworkCenter sharedInstance] getWithPath:url parameters:parameters success:successBlock failure:failureBlock];
}

#pragma mark - 发送请求
- (void)processRequest:(LCBaseRequest *)baseRequest {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = [[LCNetworkHelper sharedInstance] requestTimeoutInterval]; // 请求超时时间
//    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];  // 请求
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // 响应

    // application/json
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager = [self addRequestHeader:manager];
    //请求类型：POST GET
    NSLog(@"发送的请求体为--%@,参数--%@",baseRequest.requestUrl,baseRequest.parameters);
    NSString *url = [NSString stringWithFormat:@"%@%@", [LCNetworkHelper sharedInstance].baseUrl, baseRequest.requestUrl];

    switch (baseRequest.requestType) {
        case LCBaseRequestTypePOST: {
            [manager POST:url parameters:baseRequest.parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                baseRequest.responseJSONObject = responseObject;
                [self processSuccessResult:baseRequest];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self processFailureResult:baseRequest dataTask:task error:error];
            }];
        }
            break;
        case LCBaseRequestTypeGET: {
            [manager GET:url parameters:baseRequest.parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                baseRequest.responseJSONObject = responseObject;
                [self processSuccessResult:baseRequest];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self processFailureResult:baseRequest dataTask:task error:error];
            }];

        }
            break;
        default: {
            
        }
            break;
    }
}

#pragma mark - 处理请求成功返回的数据
- (void)processSuccessResult:(LCBaseRequest *)baseRequest {
//    NSError *error = nil;
//    NSDictionary *resultsDictionary = [NSJSONSerialization JSONObjectWithData:baseRequest.responseJSONObject options:NSJSONReadingMutableContainers error:&error];
    
    if ([baseRequest.responseJSONObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *resultsDictionary = baseRequest.responseJSONObject;
        NSLog(@"请求成功 - %s - 返回数据responseObject:%@", __func__ , resultsDictionary);
        NSInteger responseCode = [resultsDictionary[RESPONSE_CODE_KEY] integerValue];
        // 时间戳错误代码
        if (responseCode == TIME_STAMP_ERROR_CODE) {
            [self resetRequestTime:[resultsDictionary[RESPONSE_DATA_KEY][RESPONSE_TIME_STAMP_KEY] doubleValue]];
        } else if (responseCode == SESSION_ID_ERROR_CODE) {
            // sessionId 非法
            NSLog(@"sessionId 非法");
            [LCHUD hide];
            LCAccount *act = [LCAccount sharedInstance];
            if (act.sessionId.length > 0) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"您的账号已在其他地方登录，请重新登录" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [[LCAccount sharedInstance] logOut];
                    [[AppDelegate appDelegate] switchLogin];
                }];
                [alertController addAction:okAction];
                [[self visibleViewController] presentViewController:alertController animated:YES completion:NULL];
            }
            act.logined = NO;
            act.sessionId = @"";
            act.c_id = @"";
        } else if (responseCode == REQUEST_SUCCESS_CODE) {
            // 请求成功
            baseRequest.successBlock(resultsDictionary);
            // 防止 Block 里面的循环引用
            [baseRequest clearCompletionBlock];
        } else {
            // 其它情况
            
        }
        if (responseCode != REQUEST_SUCCESS_CODE && responseCode != SESSION_ID_ERROR_CODE) {
//            NSString *key = [NSString stringWithFormat:@"%ld", (long)responseCode];
//            baseRequest.failureBlock(responseCode, NSLocalizedString(key, nil));
            baseRequest.failureBlock(responseCode, resultsDictionary[RESPONSE_MSG]);
        }
    } else {
        NSLog(@"请求失败-。-  返回数据：%@", baseRequest.responseJSONObject);
        baseRequest.failureBlock(0, @"返回的数据格式错误");
    }
}

#pragma mark - 处理请求失败
- (void)processFailureResult:(LCBaseRequest *)baseRequest dataTask:(NSURLSessionDataTask *)task error:(NSError *)error {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
    NSInteger statusCode = (long)httpResponse.statusCode;
    NSLog(@"请求失败 - statusCode:%li - error:%@ errDescription:%@", (long)statusCode, error, error.localizedDescription);
    NSString *errDes = ![self isNetworkNormal] ? @"当前网络不可用，请检查网络连接！" : error.localizedDescription;
    baseRequest.failureBlock(statusCode, errDes);
}

#pragma mark - 增加公共请求头
- (AFHTTPSessionManager *)addRequestHeader:(AFHTTPSessionManager *)manager {
    LCNetworkHelper *helper = [LCNetworkHelper sharedInstance];
    NSDictionary *headerFieldValueDictionary = [helper createRequestHeader];
    
    if (headerFieldValueDictionary != nil) {
        for (id httpHeaderField in headerFieldValueDictionary.allKeys) {
            id value = headerFieldValueDictionary[httpHeaderField];
            if ([httpHeaderField isKindOfClass:[NSString class]] && [value isKindOfClass:[NSString class]]) {
                [manager.requestSerializer setValue:(NSString *)value forHTTPHeaderField:(NSString *)httpHeaderField];
            } else {
                NSLog(@"增加公共请求头出错");
            }
        }
    }
    
    return manager;
}

#pragma mark - 修正时间戳
- (void)resetRequestTime:(double)time {
    [LCNetworkHelper sharedInstance].requestTime = time;
}

+ (void)resetRequestTime:(double)time {
    [[LCNetworkCenter sharedInstance] resetRequestTime:time];
}

#pragma mark - 网络状态监听
- (void)startMonitoring {
    NSLog(@"startMonitoring - 开始网络状态监听");
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        self.reachabilityStatus = status;
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: {
                NSLog(@"%s - 当前网络状态 - 未知网络状态", __func__);
            }
                break;
            case AFNetworkReachabilityStatusNotReachable: {
                NSLog(@"%s - 当前网络状态 - 无网络", __func__);
                [[NSNotificationCenter defaultCenter] postNotificationName:LCNetworkCenterNotificationReachabilityStatusNotReachable
                                                                    object:nil
                                                                  userInfo:nil];
//                [MBProgressHUD hideOldHudsThenShowError:NSLocalizedString(@"tips.noNetworks", nil) toView:nil];
            }
                break;                
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                NSLog(@"%s - 当前网络状态 - 蜂窝网络", __func__);
//                [LCUploadHelper checkUpladFile];
                [[NSNotificationCenter defaultCenter] postNotificationName:LCNetworkCenterNotificationReachabilityStatusReachableViaWWAN
                                                                    object:nil
                                                                  userInfo:nil];
            }
                break;                
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                NSLog(@"%s - 当前网络状态 - WIFI", __func__);
//                [LCUploadHelper checkUpladFile];
                [[NSNotificationCenter defaultCenter] postNotificationName:LCNetworkCenterNotificationReachabilityStatusReachableViaWiFi
                                                                    object:nil
                                                                  userInfo:nil];
            }
                break;
            default:
                break;
        }
    }];
}

#pragma mark - 当前网络可用
- (BOOL)isNetworkNormal {
    BOOL status = (self.reachabilityStatus != AFNetworkReachabilityStatusUnknown) && (self.reachabilityStatus != AFNetworkReachabilityStatusNotReachable);
    NSLog(@"当前网络是否可用 - status:%u", status);
    return status;
}

@end
