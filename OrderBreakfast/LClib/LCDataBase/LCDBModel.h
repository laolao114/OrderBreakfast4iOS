//
//  LCDBModel.h
//
//  Created by yaoyunheng on 2017/5/19.
//  Copyright © 2017年 yaoyunheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCDBModel : NSObject

@end

#pragma mark - LCAddressListDataModel

@interface LCAddressListDataModel : NSObject

@property (nonatomic, strong) NSString *region_id;
@property (nonatomic, strong) NSString *region_name;
@property (nonatomic, strong) NSString *region_level;
@property (nonatomic, strong) NSString *end_flag;

@end

#pragma mark - LCSysContnetModel

@interface LCSysContnetModel : NSObject

// id
@property (nonatomic, strong) NSString *c_id;
// 内容
@property (nonatomic, strong) NSString *content;
// play_method 玩法介绍 agreement：协议
@property (nonatomic, strong) NSString *item;

@end


#pragma mark - LCDBUpdateModel

@class LCDBUpdateData;
@interface LCDBUpdateModel : NSObject

@property (nonatomic, assign) NSInteger ret;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) LCDBUpdateData *data;

@end

@interface LCDBUpdateData : NSObject

@property (nonatomic, strong) NSArray *ft_sys_content;
@property (nonatomic, strong) NSArray *ft_region;


@end
