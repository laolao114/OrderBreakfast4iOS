//
//  LCAddressPickerView.h
//  HeJing
//
//  Created by old's mac on 2017/7/5.
//  Copyright © 2017年 GZLC. All rights reserved.
//

#import "LCCustomPickerView.h"
#import "LCDBManage.h"

@interface LCAddressPickerView : LCCustomPickerView

@property (nonatomic, copy) void(^didSelectBlock)(NSString *province, NSString *city, NSString *area);
@property (nonatomic, copy) void(^didSelectIndexBlock)(NSInteger provinceIndex, NSInteger cityIndex, NSInteger areaIndex);

- (void)configViewWith:(NSInteger)proIndex andCityIndex:(NSInteger)cIndex andAreaIndex:(NSInteger)arIndex;
- (void)configViewWith:(NSString *)proName andCityName:(NSString *)cityName andAreaName:(NSString *)areaName;

@end
