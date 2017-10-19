//
//  OrderDetailModel.h
//  OrderBreakfast
//
//  Created by old's mac on 2017/9/10.
//  Copyright © 2017年 scnu. All rights reserved.
//

#import "LCBaseModel.h"

@class OrderDetailModelData;

@interface OrderDetailModel : LCBaseModel

@property (nonatomic, strong) OrderDetailModelData *data;

@end

@interface OrderDetailModelData : NSObject

@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *status;

@end
