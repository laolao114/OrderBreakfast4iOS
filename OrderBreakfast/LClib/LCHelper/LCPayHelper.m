//
//  LCPayHelper.m
//  WineWarehouse
//
//  Created by yaoyunheng on 2017/2/6.
//  Copyright © 2017年 GZLC. All rights reserved.
//

#import "LCPayHelper.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "WXApi.h"

#define AlipayPayAppID @"";

@interface LCPayHelper ()

@end

@implementation LCPayHelper

+ (LCPayHelper *)sharedInstance {
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
        // 注册支付成功通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccessAct) name:LCNotifyAliPaySuccess object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccessAct) name:LCNotifyWechatPaySuccess object:nil];
    }
    return self;
}

- (void)alipayWithPayData:(LCPayData *)payData {
    NSString *appID = AlipayPayAppID;
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [Order new];

    // NOTE: app_id设置
    order.app_id = appID;

    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";

    // NOTE: 参数编码格式
    order.charset = @"utf-8";

    // NOTE: 当前时间点
    order.timestamp = payData.timestamp;

    // NOTE: 支付版本
    order.version = @"1.0";

    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = payData.sign_type;

    // 支付宝服务器主动通知商户服务器里指定的页面http路径
    order.notify_url = payData.notify_url;

    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = payData.body;
    order.biz_content.subject = payData.subject;
    order.biz_content.out_trade_no = payData.out_trade_no;
    order.biz_content.timeout_express = @"30m"; // 超时时间设置
    order.biz_content.total_amount = payData.total_amount; // 商品价格
    order.biz_content.seller_id = payData.seller_id;

    //将商品信息拼接成字符串
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];

    // NOTE: 如果加签成功，则继续执行支付
    if (payData.sign != nil) {
        // 应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"chubankuaiURL";
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, payData.sign];
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSString *ret_code = resultDic[@"resultStatus"];
            if (![ret_code isEqualToString:@"9000"]) {
                [LCHUD showError:@"支付失败" target:nil];
                return;
            }
            if (self.paySuccessBlock) {
                self.paySuccessBlock();
            }
        }];
    }

}

- (void)alipayWithOrderString:(NSString *)orderString {
    if (orderString == nil || orderString.length == 0) {
        return;
    }
    // 应用注册scheme,在 应用-Info.plist定义URL types
    NSString *appScheme = @"chubankuaiURL";
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        /*支付结果回调Block，用于wap支付结果回调（非跳转钱包支付）*/
        NSLog(@"reslut = %@",resultDic);
        NSString *ret_code = resultDic[@"resultStatus"];
        if (![ret_code isEqualToString:@"9000"]) {
            [LCHUD showDelayError:@"支付失败" target:nil];
            return;
        }
        if (self.paySuccessBlock) {
            self.paySuccessBlock();
        }
    }];
}

- (void)paySuccessAct {
    if (self.paySuccessBlock) {
        self.paySuccessBlock();
    }
}

- (void)wechatPayWithPayData:(LCWechatPayData *)payData {
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = payData.partnerid;
    request.prepayId = payData.prepayid;
    request.package  = payData.package;
    request.nonceStr = payData.noncestr;
    request.timeStamp = [payData.timestamp intValue];
    request.sign = payData.sign;
    [WXApi sendReq:request];
}

@end

@implementation LCPayModel

@end

@implementation LCPayData

@end

@implementation LCWechatPayModel

@end

@implementation LCWechatPayData

@end


