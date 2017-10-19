//
//  CreateOrderAddressCell.h
//  chubankuai
//
//  Created by old's mac on 2017/5/27.
//  Copyright © 2017年 gzlc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAddressListModel.h"

@interface CreateOrderAddressCell : UITableViewCell

@property (nonatomic, copy) void(^cellHeightDidChange)(NSInteger height);

- (void)configCellWithAddressModel:(id)addressModel;

@end
