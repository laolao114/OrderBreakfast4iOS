//
//  MyAddressListModel.m
//  HeJing
//
//  Created by old's mac on 2017/7/5.
//  Copyright © 2017年 GZLC. All rights reserved.
//

#import "MyAddressListModel.h"

@implementation MyAddressListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"data" : [MyAddressListModelData class]
             };
}

@end

@implementation MyAddressListModelData

@end
