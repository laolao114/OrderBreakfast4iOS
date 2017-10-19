//
//  LCLibEnum.h
//  LCModularization
//
//  Created by yaoyunheng on 2017/3/27.
//  Copyright © 2017年 GZLC. All rights reserved.
//
//  定义项目的枚举

#ifndef LCLibEnum_h
#define LCLibEnum_h

#pragma mark - 分享
typedef NS_ENUM (NSInteger, LCShareType) {
    LCShareTypeUnknown = 0,
    LCShareTypeWechatSession = 1, // 微信好友
    LCShareTypeWechatTimeline,    // 微信朋友圈
    LCShareTypeQQFriend,          // QQ好友
    LCShareTypeQZone,             // QQ空间
    LCShareTypeSinaWeibo          // 新浪微博
};

typedef NS_ENUM (NSInteger, LCLoginType) {
    LCLoginTypeUnknown = 0,
    LCLoginTypeWechat  = 1,  // 微信
    LCLoginTypeQQ      = 2,  // QQ
    LCLoginTypeWeibo   = 3   // 新浪微博
};


#endif /* LCLibEnum_h */
