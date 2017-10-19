//
//  MyAddressListModel.h
//  HeJing
//
//  Created by old's mac on 2017/7/5.
//  Copyright © 2017年 GZLC. All rights reserved.
//

#import "LCBaseModel.h"

@class MyAddressListModelData;

@interface MyAddressListModel : LCBaseModel

@property (nonatomic, strong) NSArray<MyAddressListModelData *> *data;

@end

@interface MyAddressListModelData : NSObject

@property (nonatomic, strong) NSString *addressId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *address;

@end
