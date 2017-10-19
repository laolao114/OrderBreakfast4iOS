//
//  LCOSSKeyGetHelper.m
//  chubankuai
//
//  Created by old's mac on 2017/5/22.
//  Copyright © 2017年 gzlc. All rights reserved.
//

#import "LCOSSKeyGetHelper.h"
#import "LCCacheHelper.h"

static NSString *const ossAccessKey = @"chubankuai-OssAccessKey";

@implementation OSSKeyModel

@end

@implementation OSSKeyModelData

- (void)encodeWithCoder:(NSCoder *)encoder {
    [self modelEncodeWithCoder:encoder];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    return [self modelInitWithCoder:decoder];
}

@end

@implementation LCOSSKeyGetHelper

+ (LCOSSKeyGetHelper *)sharedInstance {
    static LCOSSKeyGetHelper* _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        if (![[LCCacheHelper sharedInstance].cache containsObjectForKey:ossAccessKey]) {
            _isSentRequest = NO;
            [self updateKey:nil];
        }
    }
    return self;
}

- (void)sendKeyRequest:(void(^)(OSSKeyModelData *newKeyData))successBlock {
    [LCNetworkCenter getWithPath:@"Order.get_sts_token" parameters:@{} success:^(id responseObject) {
        _isSentRequest = NO;
        OSSKeyModel *model = [OSSKeyModel modelWithJSON:responseObject];
        _keyData = model.data;
        [[LCCacheHelper sharedInstance].cache setObject:(id)model.data forKey:ossAccessKey];
        if (successBlock) {
            successBlock(_keyData);
        }
    } failure:^(NSInteger errCode, NSString *errDescription) {
        if (successBlock) {
            successBlock(nil);
        }
    }];
}

- (void)updateKey:(void(^)(OSSKeyModelData *data))successBlock {
    if (!_isSentRequest) {
        [self sendKeyRequest:^(OSSKeyModelData *newKeyData) {
            _isSentRequest = NO;
            if (successBlock) {
                successBlock(newKeyData);
            }
        }];
        _isSentRequest = YES;
    }
}

- (void)getKeyData:(void(^)(OSSKeyModelData *keyData))successBlock {
    if ([[LCCacheHelper sharedInstance].cache containsObjectForKey:ossAccessKey]) {
        _keyData = (OSSKeyModelData *)[[LCCacheHelper sharedInstance].cache objectForKey:ossAccessKey];
        if (successBlock) {
            successBlock(_keyData);
        }
    } else {
        [self updateKey:^(OSSKeyModelData *data) {
            if (successBlock) {
                successBlock(data);
            }
        }];
    }
}

@end
