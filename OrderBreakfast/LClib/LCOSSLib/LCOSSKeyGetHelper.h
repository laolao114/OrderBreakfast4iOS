//
//  LCOSSKeyGetHelper.h
//  chubankuai
//
//  Created by old's mac on 2017/5/22.
//  Copyright © 2017年 gzlc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OSSKeyModelData;

@interface OSSKeyModel : LCBaseModel

@property (nonatomic, strong) OSSKeyModelData *data;

@end

@interface OSSKeyModelData : NSObject

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *AccessKeyId;
@property (nonatomic, strong) NSString *AccessKeySecret;
@property (nonatomic, strong) NSString *Expiration;
@property (nonatomic, strong) NSString *SecurityToken;

@end


@interface LCOSSKeyGetHelper : NSObject

@property (nonatomic, assign) BOOL isSentRequest;       // 是否已经发送了请求
@property (nonatomic, strong) OSSKeyModelData *keyData;

+ (LCOSSKeyGetHelper *)sharedInstance;
- (void)updateKey:(void(^)(OSSKeyModelData *data))successBlock;
- (void)getKeyData:(void(^)(OSSKeyModelData *keyData))successBlock;

@end
