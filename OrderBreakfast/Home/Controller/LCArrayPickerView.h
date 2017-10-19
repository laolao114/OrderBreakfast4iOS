//
//  LCArrayPickerView.h
//  chubankuai
//
//  Created by old's mac on 2017/5/15.
//  Copyright © 2017年 gzlc. All rights reserved.
//

#import "LCCustomPickerView.h"

@interface LCArrayPickerView : LCCustomPickerView

@property (nonatomic, copy) void(^didSelectPayBlock)(NSString *selectString, NSInteger index);
@property (nonatomic, assign) NSInteger selectedIndex;

- (instancetype)initWithArray:(NSArray *)dataArray;

@end
