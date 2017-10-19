//
//  LCCacheHelper.h
//  WineWarehouse
//
//  Created by yaoyunheng on 2016/11/2.
//  Copyright © 2016年 GZLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCCacheHelper : NSObject

@property (strong, nonatomic) YYCache *cache;

+ (LCCacheHelper *)sharedInstance;

@end
