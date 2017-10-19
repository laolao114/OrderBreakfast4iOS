//
//  OrderListHistoryCell.h
//  chubankuai
//
//  Created by old's mac on 2017/6/5.
//  Copyright © 2017年 gzlc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"

@interface OrderListHistoryCell : UITableViewCell

@property (nonatomic, assign) BOOL noLines;
@property (nonatomic, assign) BOOL needsArrow;
@property (nonatomic, strong) OrderListModelData *model;

@end
