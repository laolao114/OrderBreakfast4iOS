//
//  LCAccount.h
//
//  Created by yaoyunheng on 2016/10/17.
//  Copyright © 2016年 GZLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCUserProfileModel.h"
#import "LCLoginModel.h"

@class LCUserProfileModel, LCLoginModel;

@interface LCAccount : NSObject

// ------------ 常用属性 -------------------
@property (nonatomic) BOOL logined; // 是否登录
@property (nonatomic) BOOL isFirstLogin; // 是否第一次登录
@property (nonatomic) BOOL imLogined; // 是否登录IM
@property (nonatomic) BOOL is_change;   // 是否设置过密码
@property (nonatomic, copy) NSString *deviceToken; // 设备标识
@property (nonatomic, copy) NSString *sessionId;   // 登录
@property (nonatomic, copy) NSString *c_id;        // 用户ID
@property (nonatomic, copy) NSString *mobileNum;   // 手机号码
@property (nonatomic, copy) NSArray *recieveNotify;// 消息通知打开或者关闭的状态
@property (nonatomic, assign) NSInteger activateTime;// 激活次数
@property (nonatomic, assign) NSInteger unreadCount; // 通知未读数 其他消息未读数
@property (nonatomic) BOOL haveUnreadCount; // 是否有其他未读消息
@property (nonatomic) BOOL haveCurrentAuctionMessageCount; // 是否有当前竞拍未读消息
@property (nonatomic, copy) NSString *downloadPage;  // 官网下载地址

// ------------ 个人信息model --------------------
@property (nonatomic, strong) LCUserProfileModel *userInfo;

+ (instancetype)sharedInstance;

// 退出登录
- (void)logOut;

/**
 *  获取本地缓存用户个人信息的model
 */
+ (LCUserProfileModel *)getUserProfileModel;

/**
 *  更新本地缓存用户个人信息的model
 */
+ (void)updateUserProfileModel:(LCUserProfileModel *)newModel;

@end
