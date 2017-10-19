//
//  LCUserProfileModel.h
//
//  Created by yaoyunheng on 2016/10/25.
//  Copyright © 2016年 GZLC. All rights reserved.
//

#import "LCBaseModel.h"

@class UserProfileData;

@interface LCUserProfileModel : NSObject

@property (nonatomic, assign) NSInteger ret;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) UserProfileData *data;

@end

@interface UserProfileData : NSObject

@property (nonatomic, strong) NSString *c_id;               // 用户id
@property (nonatomic, strong) NSString *customer_name;      // 客户名称
@property (nonatomic, strong) NSString *customer_code;      // 客户编号
@property (nonatomic, strong) NSString *linker;             // 联系人
@property (nonatomic, strong) NSString *linker_phone;       // 联系人电话
@property (nonatomic, strong) NSString *address;            // 厂址
@property (nonatomic, strong) NSString *balance;            // 余额
@property (nonatomic, strong) NSString *balance_limit;      // 余额预警值
@property (nonatomic, strong) NSString *type;               // 客户类型 1-预存 2-现结 3-月结
@property (nonatomic, strong) NSString *nopay_money;        // 未结算的金额

@end
