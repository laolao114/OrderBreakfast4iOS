//
//  MyAddressListController.h
//  HeJing
//
//  Created by old's mac on 2017/7/5.
//  Copyright © 2017年 GZLC. All rights reserved.
//

#import "LCBaseViewController.h"
#import "MyAddressListModel.h"

@interface MyAddressListController : LCBaseViewController

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) void(^MyDidSelectAddressBlock)(MyAddressListModelData *addressData, NSInteger index);

@end
