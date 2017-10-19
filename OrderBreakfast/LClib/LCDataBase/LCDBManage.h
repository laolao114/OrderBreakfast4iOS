//
//  LCDBManage.h
//
//  Created by yaoyunheng on 2016/11/9.
//  Copyright © 2016年 GZLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCDBModel.h"

// 国家名字 手机区号时使用
#define COUNTRY_NAME_KEY @"COUNTRY_NAME_KEY"
// 手机区号
#define MOBILE_PREFIX_KEY @"MOBILE_PREFIX_KEY"

@class LCAddressListDataModel;

@interface LCDBManage : NSObject

+ (LCDBManage *)sharedInstance;

/**
 更新db
 */
- (void)updateDB;

/**
 清除db数据
 */
- (void)clearAllData;

/**
 获取本地数据库的最后更新时间
 */
- (NSString *)getMaxTimeInterval;

/**
 更新本地数据库
 */
- (void)updateInfoWithSql:(NSString *)sql;

#pragma mark - 地区

/**
 获取全部国家数据
 */
- (NSMutableArray<LCAddressListDataModel *> *)getAllCountryData;

/*
 获取中国下的全部省份
 */
- (NSMutableArray<LCAddressListDataModel *> *)getAllProvinceInChina;

/**
 获取某个国家下的省份
 @param countryID 国家ID
 */
- (NSMutableArray<LCAddressListDataModel *> *)getProvinceDataFrom:(NSString *)countryID;

/**
 获取某个省下面的城市数据
 @param provinceID 省份ID
 */
- (NSMutableArray<LCAddressListDataModel *> *)getCityDataFrom:(NSString *)provinceID;

/**
 获取某个市下面的区县数据
 @param cityID 城市ID
 */
- (NSMutableArray<LCAddressListDataModel *> *)getDistrictDataFrom:(NSString *)cityID;

#pragma mark - 手机号码前缀

/**
 @Returns 获取国家号码前缀
 */
- (NSDictionary *)getMobilePrefix;

#pragma mark - 系统配置

/**
 @Returns 获取玩法介绍
 */
- (NSString *)getPlayMethod;

/**
 @Returns 获取期货众筹投资协议
 */
- (NSString *)getAgreement;

@end
