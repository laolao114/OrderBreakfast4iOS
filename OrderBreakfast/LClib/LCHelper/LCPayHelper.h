//
//  LCPayHelper.h
//  WineWarehouse
//
//  Created by yaoyunheng on 2017/2/6.
//  Copyright © 2017年 GZLC. All rights reserved.
//

@class LCPayData,LCWechatPayData;

@interface LCPayModel : NSObject

@property (nonatomic, strong) LCPayData *data;

@end

@interface LCPayData : NSObject

@property (nonatomic, strong) NSString *order_string;
@property (nonatomic, strong) NSString *sign_type;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *notify_url;
@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString *seller_id;
@property (nonatomic, strong) NSString *out_trade_no;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *total_amount;

@end

@interface LCWechatPayModel : NSObject

@property (nonatomic, assign) NSInteger ret;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) LCWechatPayData *data;

@end

@interface LCWechatPayData : NSObject

/** 商家向财付通申请的商家id */
@property (nonatomic, strong) NSString *partnerid;
/** 预支付订单 */
@property (nonatomic, strong) NSString *prepayid;
/** 随机串，防重发 */
@property (nonatomic, strong) NSString *noncestr;
/** 时间戳，防重发 */
@property (nonatomic, strong) NSString *timestamp;
/** 商家根据财付通文档填写的数据和签名 */
@property (nonatomic, strong) NSString *package;
/** 商家根据微信开放平台文档对数据做的签名 */
@property (nonatomic, strong) NSString *sign;

@property (nonatomic, strong) NSString *appid;

@end

#import <Foundation/Foundation.h>

// 支付成功回调
typedef void (^PaySuccessBlock)();

@interface LCPayHelper : NSObject

@property (nonatomic, copy) PaySuccessBlock paySuccessBlock;

+ (LCPayHelper *)sharedInstance;

/**
 *  支付宝支付接口
 *
 *  @param payData        支付信息
 */
- (void)alipayWithPayData:(LCPayData *)payData;

/**
 *  支付宝支付接口
 *
 *  @param orderString       订单信息
 */
- (void)alipayWithOrderString:(NSString *)orderString;


/**
 微信支付接口
 
 @param payData 支付信息
 */
- (void)wechatPayWithPayData:(LCWechatPayData *)payData;

@end
