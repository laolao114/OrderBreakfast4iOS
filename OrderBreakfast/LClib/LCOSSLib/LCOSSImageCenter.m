//
//  LCOSSImageCenter.m
//  chubankuai
//
//  Created by old's mac on 2017/7/13.
//  Copyright © 2017年 gzlc. All rights reserved.
//

#import "LCOSSImageCenter.h"
#import "OSSService.h"
#import "OSSCompat.h"
#import "LCOSSKeyGetHelper.h"
#import "LCUploadFileRequest.h"

@implementation LCOSSImageCenter

+ (LCOSSImageCenter *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - 访问图片

/**
 *  STS鉴权模式下把一个objectKey转换为可访问的url
 *
 *  @param objectKey oss图片的object_key
 *
 *  @param successBlock 成功回调 responseObject返回的是一个图片url地址
 *
 */

+ (void)convertObjectKey:(NSString *)objectKey toURLStringBlock:(LCNetworkSuccessBlock)successBlock {
    [[LCOSSImageCenter sharedInstance] convertObjectKey:objectKey toURLStringBlock:successBlock];
}

- (void)convertObjectKey:(NSString *)objectKey toURLStringBlock:(LCNetworkSuccessBlock)successBlock {
    __block NSString *resultUrlString = @"";
    [[LCOSSKeyGetHelper sharedInstance] getKeyData:^(OSSKeyModelData *keyData) {
        id<OSSCredentialProvider> credential = [[OSSFederationCredentialProvider alloc]initWithFederationTokenGetter:^OSSFederationToken *{
            OSSFederationToken *res = [[OSSFederationToken alloc]init];
            res.tAccessKey = keyData.AccessKeyId;
            res.tSecretKey = keyData.AccessKeySecret;
            res.tToken = keyData.SecurityToken;
            return res;
        }];
        OSSClient *client = [[OSSClient alloc] initWithEndpoint:ossEndPoint credentialProvider:credential];
        OSSTask *task = [client presignConstrainURLWithBucketName:ossBucket withObjectKey:objectKey withExpirationInterval:30 * 60];
        if (!task.error) {
            resultUrlString = task.result;
            if (successBlock) {
                successBlock(resultUrlString);
            }
        } else {
            NSLog(@"error : %@",task.error);
        }
    }];
}

/**
 *  STS鉴权模式下把一组objectKey转换为可访问的url数组
 *
 *  @param objectKeys oss图片的object_key数组
 *
 *  @param successBlock 成功回调 responseObject返回一个图片url数组
 *
 */

+ (void)convertObjectKeys:(NSArray *)objectKeys toUrlArrayBlock:(LCNetworkSuccessBlock)successBlock {
    [[LCOSSImageCenter sharedInstance] convertObjectKeys:objectKeys toUrlArrayBlock:successBlock];
}

- (void)convertObjectKeys:(NSArray *)objectKeys toUrlArrayBlock:(LCNetworkSuccessBlock)successBlock {
    [[LCOSSKeyGetHelper sharedInstance] getKeyData:^(OSSKeyModelData *keyData) {
        NSMutableArray *resArray = [NSMutableArray array];
        __block NSInteger count = 0;
        dispatch_queue_t picQueue = dispatch_queue_create("PIC_QUEUE_CREATE", DISPATCH_QUEUE_CONCURRENT);
        [objectKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            dispatch_async(picQueue, ^{
                [self convertObjectKey:obj toURLStringBlock:^(id responseObject) {
                    count ++ ;
                    [resArray addObject:responseObject];
                    if (resArray.count == objectKeys.count) {
                        if (successBlock) {
                            successBlock(resArray);
                        }
                    }
                }];
            });
        }];
    }];
}

#pragma mark - 下载图片

/**
 *  STS鉴权模式下载一张图片
 *
 *  @param objectKey oss图片的object_key
 *
 *  @param successBlock 成功回调
 *
 */

+ (void)downloadImgeWithKey:(NSString *)objectKey successBlock:(LCNetworkSuccessBlock)successBlock {
    [[LCOSSImageCenter sharedInstance] downloadImgeWithKey:objectKey successBlock:successBlock];
}

- (void)downloadImgeWithKey:(NSString *)objectKey successBlock:(LCNetworkSuccessBlock)successBlock {
    if (objectKey.length == 0) {      // 如果key不存在，则返回失败图片
        if (successBlock) {
            successBlock([UIImage imageNamed:failImageName]);
        }
        return;
    }
    // 这里使用key作为缓存的key，所以要求这个key只不能重复，这个要和服务端约定好
    if ([[LCCacheHelper sharedInstance].cache containsObjectForKey:objectKey]) {
        UIImage *resImage = (UIImage *)[[LCCacheHelper sharedInstance].cache objectForKey:objectKey];
        if (resImage) {         // 如果图片已经缓存过了，就返回缓存的图片
            if (successBlock) {
                successBlock(resImage);
            }
            return;
        }
    }
    // 获取STS临时凭证
    [[LCOSSKeyGetHelper sharedInstance] getKeyData:^(OSSKeyModelData *keyData) {
        __block UIImage *resImage = nil;
        [self createTaskWithKey:objectKey andKeyData:keyData andResBlock:^(OSSTask *task) {
            [task continueWithBlock:^id(OSSTask *task) {
                if (!task.error) {
                    OSSGetObjectResult * getResult = task.result;
                    resImage = [UIImage imageWithData:getResult.downloadedData];
                    [[LCCacheHelper sharedInstance].cache setObject:resImage forKey:objectKey];
                    if (successBlock) {
                        successBlock(resImage);
                    }
                } else {
                    NSLog(@"download object failed, error: %@" ,task.error);
                    if (task.error.code == -404) {      // -404是oss图库中没有这个key的图片，所以不用更新accesskey
                        if(successBlock) {
                            successBlock([UIImage imageNamed:failImageName]);
                        }
                        return nil;
                    }
                    // 如果key更新失败就再获取一遍key
                    [LCOSSKeyGetHelper sharedInstance].isSentRequest = NO;
                    [[LCOSSKeyGetHelper sharedInstance] updateKey:^(OSSKeyModelData *data) {
                        [self createTaskWithKey:objectKey andKeyData:keyData andResBlock:^(OSSTask *newTask) {
                            [newTask continueWithBlock:^id(OSSTask *newTask) {
                                if (!newTask.error) {
                                    NSLog(@"download object success!");
                                    OSSGetObjectResult * getResult = newTask.result;
                                    resImage = [UIImage imageWithData:getResult.downloadedData];
                                    if (successBlock) {
                                        successBlock(resImage);
                                    }
                                } else {
                                    if (successBlock) {
                                        successBlock([UIImage imageNamed:failImageName]);
                                    }
                                }
                                return nil;
                            }];
                        }];
                    }];
                }
                return nil;
            }];
            
        }];
    }];
}

- (void)createTaskWithKey:(NSString *)key andKeyData:(OSSKeyModelData *)keyData andResBlock:(void(^)(OSSTask *task))resBlock {
    OSSGetObjectRequest *request = [OSSGetObjectRequest new];
    request.bucketName = ossBucket;
    request.objectKey = key;
    request.downloadProgress = ^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        //        NSLog(@"%lld, %lld, %lld", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
    };
    // 明文设置secret的方式建议只在测试时使用，更多鉴权模式参考后面链接给出的官网完整文档的`访问控制`章节
    id<OSSCredentialProvider> credential = [[OSSFederationCredentialProvider alloc]initWithFederationTokenGetter:^OSSFederationToken *{
        OSSFederationToken *res = [[OSSFederationToken alloc]init];
        res.tAccessKey = keyData.AccessKeyId;
        res.tSecretKey = keyData.AccessKeySecret;
        res.tToken = keyData.SecurityToken;
        return res;
    }];
    
    OSSClient *client = [[OSSClient alloc] initWithEndpoint:ossEndPoint credentialProvider:credential];
    OSSTask *getTask = [client getObject:request];
    if(resBlock) {
        resBlock(getTask);
    }
    
}

/**
 *  STS鉴权模式下载多张图片
 *
 *  @param keyArray oss图片的object_key数组
 *
 *  @param successBlock 成功回调 responseObject返回的是一个UIImage对象数组
 *
 */

+ (void)downloadImagesWithKeysArray:(NSArray *)keyArray successBlock:(LCNetworkSuccessBlock)successBlock {
    [[LCOSSImageCenter sharedInstance]downloadImagesWithKeysArray:keyArray successBlock:successBlock];
}

- (void)downloadImagesWithKeysArray:(NSArray *)keyArray successBlock:(LCNetworkSuccessBlock)successBlock {
    [[LCOSSKeyGetHelper sharedInstance] getKeyData:^(OSSKeyModelData *keyData) {
        NSMutableArray *resArray = [NSMutableArray array];
        __block NSInteger count = 0;
        dispatch_queue_t picQueue = dispatch_queue_create("PIC_QUEUE_CREATE", DISPATCH_QUEUE_CONCURRENT);
        [keyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            dispatch_async(picQueue, ^{
                [self downloadImgeWithKey:obj successBlock:^(id responseObject) {
                    count ++ ;
                    if (responseObject) {
                        [resArray addObject:responseObject];
                    } else {
                        [resArray addObject:[UIImage new]];
                    }
                    if (resArray.count == keyArray.count) {
                        if (successBlock) {
                            for (int idx = (int)resArray.count - 1; idx >= 0; idx --) {
                                // 去掉空白的图片
                                UIImage *obj2 = resArray[idx];
                                if (obj2.size.width == 0 && obj2.size.height == 0) {
                                    [resArray removeObject:obj2];
                                }
                            }
                            successBlock(resArray);
                        }
                    }
                }];
            });
        }];
    }];
}

#pragma mark - 上传图片

/**
 *  上传图片到服务器
 *
 *  @param image 图片
 *
 *  @param successBlock 成功回调 responseObject返回的是一个图片url地址
 *
 */

- (void)uploadImageWithImage:(UIImage *)image andSuccessBlock:(LCNetworkSuccessBlock)successBlock andFailBlock:(LCNetworkFailureBlock)failureBlock {
    LCUploadFileRequest *request = [LCUploadFileRequest new];
    request.successBlock = successBlock;
    request.failureBlock = failureBlock;
    request.paramName = @"file";
    [[LCOSSImageCenter sharedInstance] processUploadFileRequest:request];
}

+ (void)uploadImageWithImage:(UIImage *)image andSuccessBlock:(LCNetworkSuccessBlock)successBlock andFailBlock:(LCNetworkFailureBlock)failureBlock {
    [[LCOSSImageCenter sharedInstance] uploadImageWithImage:image andSuccessBlock:successBlock andFailBlock:failureBlock];
}

/**
 *  上传图片到服务器
 *
 *  @param imageArray 图片数组
 *
 *  @param successBlock 成功回调 responseObject返回的是一个图片url地址数组
 *
 */

-  (void)uploadImageWithImages:(NSArray *)imageArray andSuccessBlock:(LCNetworkSuccessBlock)successBlock andFailBlock:(LCNetworkFailureBlock)failureBlock {
    NSMutableArray *resArray = [NSMutableArray array];
    __block NSInteger count = 0;
    dispatch_queue_t picQueue = dispatch_queue_create("PIC_QUEUE_CREATE", DISPATCH_QUEUE_CONCURRENT);
    [imageArray enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dispatch_async(picQueue, ^{
            [self uploadImageWithImage:obj andSuccessBlock:^(id responseObject) {
                [resArray addObject:responseObject];
                count ++ ;
                if (resArray.count == imageArray.count) {
                    if (successBlock) {
                        successBlock(resArray);
                    }
                }
            } andFailBlock:^(NSInteger errCode, NSString *errDescription) {
                [LCHUD showDelayError:errDescription target:nil];
            }];
        });
    }];
}

+ (void)uploadImageWithImages:(NSArray *)imageArray andSuccessBlock:(LCNetworkSuccessBlock)successBlock andFailBlock:(LCNetworkFailureBlock)failureBlock {
    [[LCOSSImageCenter sharedInstance] uploadImageWithImages:imageArray andSuccessBlock:successBlock andFailBlock:failureBlock];
}

#pragma mark - 上传文件请求
- (void)processUploadFileRequest:(LCUploadFileRequest *)fileRequest {
    //1。创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager = [self addRequestHeader:manager];
    NSLog(@"%s - api:%@ - uploadUrl:%@", __func__, fileRequest.requestUrl, fileRequest.uploadUrl);
    [manager POST:fileRequest.uploadUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传文件参数
        NSData *data = nil;
        NSString *fileName = nil;
        NSString *mimeType = nil;
        if (fileRequest.imageFile) {
            if ([fileRequest.fileSuffix isEqualToString:@"png"]) {
                data = UIImagePNGRepresentation(fileRequest.imageFile);
                fileName = @"name.png";
            } else {
                data = UIImageJPEGRepresentation(fileRequest.imageFile, 0.5);
                fileName = @"name.jpg";
            }
        } else if (fileRequest.video) {
            data = fileRequest.video;
            fileName = @"name.mp4";
        }
        NSString *name = fileRequest.paramName;
        mimeType = @"multipart/form-data";
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印下上传进度
        NSLog(@"上传文件请求 - 进度:%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        //        NSLog(@"上传文件请求 -请求成功：%@", responseObject);
        fileRequest.responseJSONObject = responseObject;
        [self processSuccessResult:fileRequest];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"上传文件请求 -请求失败：%@", error);
        [self processFailureResult:fileRequest dataTask:task error:error];
    }];
}

#pragma mark - 处理请求成功返回的数据
- (void)processSuccessResult:(LCBaseRequest *)baseRequest {
    if ([baseRequest.responseJSONObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *resultsDictionary = baseRequest.responseJSONObject;
        NSLog(@"请求成功 - %s - requestUrl:%@ - 返回数据:%@", __func__, baseRequest.requestUrl, [resultsDictionary jsonPrettyStringEncoded]);
        NSString *responseCode = resultsDictionary[@"data"];
        if ([responseCode isEqualToString:@"success"]) {
            if ([baseRequest isKindOfClass:[LCUploadFileRequest class]]) {
                [self factoryUploadFileRequestModel:(LCUploadFileRequest *)baseRequest];
            } else {
                baseRequest.successBlock(resultsDictionary);
                //防止 Block 里面的循环引用
                [baseRequest clearCompletionBlock];
            }
        } else if ([responseCode isEqualToString:@""] || !responseCode){
            NSLog(@"sessionId 非法");
            LCAccount *act = [LCAccount sharedInstance];
            if (act.sessionId.length > 0) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"您的账号已在其他地方登录，请重新登录" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [[LCAccount sharedInstance] logOut];
                }];
                [alertController addAction:okAction];
                [[self visibleViewController] presentViewController:alertController animated:YES completion:NULL];
            }
            act.logined = NO;
            act.sessionId = @"";
        } else {
            baseRequest.failureBlock([responseCode integerValue], [resultsDictionary[RESPONSE_MSG] isKindOfClass:[NSString class]] ? resultsDictionary[RESPONSE_MSG] : @"请求出错");
        }
    } else {
        NSLog(@"sessionId 非法");
        LCAccount *act = [LCAccount sharedInstance];
        if (act.sessionId.length > 0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"您的账号已在其他地方登录，请重新登录" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[LCAccount sharedInstance] logOut];
            }];
            [alertController addAction:okAction];
            [[self visibleViewController] presentViewController:alertController animated:YES completion:NULL];
        }
        act.logined = NO;
        act.sessionId = @"";
        NSLog(@"请求失败-。-  返回数据：%@", baseRequest.responseJSONObject);
        baseRequest.failureBlock(0, @"返回的数据格式错误");
    }
}

#pragma mark - 处理请求失败
- (void)processFailureResult:(LCBaseRequest *)baseRequest dataTask:(NSURLSessionDataTask *)task error:(NSError *)error {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
    NSInteger statusCode = (long)httpResponse.statusCode;
    NSLog(@"请求失败 - statusCode:%li - error:%@ errDescription:%@", (long)statusCode, error, error.localizedDescription);
    if ((!baseRequest.responseJSONObject || ![baseRequest.responseJSONObject isKindOfClass:[NSDictionary class]]) && statusCode == 200) {   
        
    }
    baseRequest.failureBlock(statusCode, @"请求出错");
}

#pragma mark - 得到上传文件请求返回的数据之后，生成数据模型数组
- (void)factoryUploadFileRequestModel:(LCUploadFileRequest *)fileRequest {
    fileRequest.successBlock(fileRequest.responseJSONObject);
    //防止 Block 里面的循环引用
    [fileRequest clearCompletionBlock];
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

@end
