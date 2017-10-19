//
//  OrderListModel.h
//  chubankuai
//
//  Created by old's mac on 2017/5/17.
//  Copyright © 2017年 gzlc. All rights reserved.
//

#import "LCBaseModel.h"

@class OrderListModelData;

@interface OrderListModel : LCBaseModel

@property (nonatomic, strong) NSArray<OrderListModelData *> *data;

@end

@interface OrderListModelData : NSObject

@property (nonatomic, strong) NSString *o_id;                       // 订单id
@property (nonatomic, strong) NSString *order_name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *type;                       // 类型：1.早餐 2.午餐 3.晚餐 4.快递 5.其他
@property (nonatomic, strong) NSString *limit_time;                 // 截止时间

@end
