//
//  LCCacheHelper.m
//  WineWarehouse
//
//  Created by yaoyunheng on 2016/11/2.
//  Copyright © 2016年 GZLC. All rights reserved.
//

#import "LCCacheHelper.h"

@interface LCCacheHelper ()


@end

@implementation LCCacheHelper

+ (LCCacheHelper *)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _cache = [YYCache cacheWithName:@"chubankuai"];
        [_cache.diskCache setCountLimit:100];
        [_cache.memoryCache setCountLimit:100];
    }
    return self;
}

@end
