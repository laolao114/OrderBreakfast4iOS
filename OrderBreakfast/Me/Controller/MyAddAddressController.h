//
//  MyAddAddressController.h
//  HeJing
//
//  Created by old's mac on 2017/7/5.
//  Copyright © 2017年 GZLC. All rights reserved.
//

#import "LCBaseViewController.h"
#import "MyAddressListModel.h"

@interface MyAddAddressController : LCBaseViewController

@property (nonatomic, strong) MyAddressListModelData *data;
@property (nonatomic, copy) void(^didSaveBlock)(MyAddressListModelData *newData);

@end
