//
//  CreateOrderCell.h
//  chubankuai
//
//  Created by old's mac on 2017/4/10.
//  Copyright © 2017年 gzlc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAddressListModel.h"

@interface CreateOrderCell : UITableViewCell

@property (nonatomic, strong) UITextField *textField;           // 右侧textField
@property (nonatomic, assign) BOOL needsArrow;                  // 是否需要箭头
@property (nonatomic, assign) BOOL noLines;
@property (nonatomic, assign) BOOL textFieldCanEdit;            // textfield是否可以编辑


- (void)configCellWithTitle:(NSString *)title content:(id)content;

@end
