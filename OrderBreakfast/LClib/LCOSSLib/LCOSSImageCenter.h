//
//  LCOSSImageCenter.h
//  chubankuai
//
//  Created by old's mac on 2017/7/13.
//  Copyright © 2017年 gzlc. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const ossEndPoint = @"oss-cn-shenzhen.aliyuncs.com";
static NSString *const ossBucket = @"chubankuai";
static NSString *const failImageName = @"";

@interface LCOSSImageCenter : NSObject

+ (LCOSSImageCenter *)sharedInstance;

/**
 *  STS鉴权模式下把一个objectKey转换为可访问的url
 *
 *  @param objectKey oss图片的object_key
 *
 *  @param successBlock 成功回调 responseObject返回的是一个图片url地址
 *
 */

+ (void)convertObjectKey:(NSString *)objectKey toURLStringBlock:(LCNetworkSuccessBlock)successBlock;

/**
 *  STS鉴权模式下把一组objectKey转换为可访问的url数组
 *
 *  @param objectKeys oss图片的object_key数组
 *
 *  @param successBlock 成功回调 responseObject返回一个图片url数组
 *
 */

+ (void)convertObjectKeys:(NSArray *)objectKeys toUrlArrayBlock:(LCNetworkSuccessBlock)successBlock;

/**
 *  STS鉴权模式下载一张图片
 *
 *  @param key oss图片的object_key
 *
 *  @param successBlock 成功回调 responseObject返回的是一个UIImge对象
 *
 */

+ (void)downloadImgeWithKey:(NSString *)key successBlock:(LCNetworkSuccessBlock)successBlock;

/**
 *  STS鉴权模式下载多张图片
 *
 *  @param keyArray oss图片的object_key数组
 *
 *  @param successBlock 成功回调 responseObject返回的是一个UIImage对象数组
 *
 */
+ (void)downloadImagesWithKeysArray:(NSArray *)keyArray successBlock:(LCNetworkSuccessBlock)successBlock;

/**
 *  上传图片到服务器
 *
 *  @param image 图片
 *
 *  @param successBlock 成功回调 responseObject返回的是一个图片url地址
 *
 */

+ (void)uploadImageWithImage:(UIImage *)image andSuccessBlock:(LCNetworkSuccessBlock)successBlock andFailBlock:(LCNetworkFailureBlock)failureBlock;

/**
 *  上传图片到服务器
 *
 *  @param imageArray 图片数组
 *
 *  @param successBlock 成功回调 responseObject返回的是一个图片url地址数组
 *
 */

+ (void)uploadImageWithImages:(NSArray *)imageArray andSuccessBlock:(LCNetworkSuccessBlock)successBlock andFailBlock:(LCNetworkFailureBlock)failureBlock ;

@end
