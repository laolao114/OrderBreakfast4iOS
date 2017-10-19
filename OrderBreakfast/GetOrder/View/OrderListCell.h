//
//  OrderListCell.h
//  chubankuai
//
//  Created by old's mac on 2017/4/10.
//  Copyright © 2017年 gzlc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"

@interface OrderListCell : UITableViewCell

@property (nonatomic, assign) BOOL noLines;
@property (nonatomic, strong) OrderListModelData *model;

@end
