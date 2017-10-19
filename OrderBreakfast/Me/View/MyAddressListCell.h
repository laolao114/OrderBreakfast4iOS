//
//  MyAddressListCell.h
//  HeJing
//
//  Created by old's mac on 2017/7/5.
//  Copyright © 2017年 GZLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAddressListModel.h"

@interface MyAddressListCell : UITableViewCell

@property (nonatomic, assign) BOOL noLine;
@property (nonatomic, copy) void(^didEditBlock)(void);  

- (void)configCellWith:(MyAddressListModelData *)data andIsSelected:(BOOL)isSelected;

@end
