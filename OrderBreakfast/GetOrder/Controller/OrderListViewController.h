//
//  OrderListViewController.h
//  chubankuai
//
//  Created by old's mac on 2017/4/10.
//  Copyright © 2017年 gzlc. All rights reserved.
//

#import "LCBaseViewController.h"

typedef NS_ENUM(NSInteger,OrderListType) {
    OrderListTypeProducting = 1,
    OrderListTypeHistory
};

@interface OrderListViewController : UIViewController

@property (nonatomic, assign) OrderListType type;

- (void)refresh;

@end
