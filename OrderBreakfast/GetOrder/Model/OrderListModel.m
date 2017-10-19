//
//  OrderListModel.m
//  chubankuai
//
//  Created by old's mac on 2017/5/17.
//  Copyright © 2017年 gzlc. All rights reserved.
//

#import "OrderListModel.h"

@implementation OrderListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"data" : [OrderListModelData class]
             };
}

@end

@implementation OrderListModelData

@end
