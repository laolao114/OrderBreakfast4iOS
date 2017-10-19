//
//  LCAddressPickerView.m
//  HeJing
//
//  Created by old's mac on 2017/7/5.
//  Copyright © 2017年 GZLC. All rights reserved.
//

#import "LCAddressPickerView.h"

@interface LCAddressPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *firstArray;
@property (nonatomic, strong) NSMutableArray *secondArray;
@property (nonatomic, strong) NSMutableArray *thirdArray;

@end

@implementation LCAddressPickerView {
    NSInteger provinceIndex;
    NSInteger cityIndex;
    NSInteger areaIndex;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    _pickerView = [[UIPickerView alloc]init];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self.pickerViewContainer addSubview:_pickerView];
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.pickerViewContainer);
    }];
}

- (void)configViewWith:(NSInteger)proIndex andCityIndex:(NSInteger)cIndex andAreaIndex:(NSInteger)arIndex {
    provinceIndex = proIndex;
    cityIndex = cIndex;
    areaIndex = arIndex;

    _firstArray = [[LCDBManage sharedInstance] getAllProvinceInChina];
    LCAddressListDataModel *firstProvince = _firstArray[provinceIndex];
    _secondArray = [[LCDBManage sharedInstance] getCityDataFrom:firstProvince.region_id];
    LCAddressListDataModel *firstCity = _secondArray[cityIndex];
    _thirdArray = [[LCDBManage sharedInstance] getCityDataFrom:firstCity.region_id];
}

- (void)configViewWith:(NSString *)proName andCityName:(NSString *)cityName andAreaName:(NSString *)areaName {
    _firstArray = [[LCDBManage sharedInstance] getAllProvinceInChina];
    if (proName.length > 0) {
        [_firstArray enumerateObjectsUsingBlock:^(LCAddressListDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.region_name isEqualToString:proName]) {
                provinceIndex = idx;
                *stop = YES;
            }
        }];
    } else {
        provinceIndex = 0;
    }
    LCAddressListDataModel *firstProvince = _firstArray[provinceIndex];
    _secondArray = [[LCDBManage sharedInstance] getCityDataFrom:firstProvince.region_id];
    if (cityName.length > 0) {
        [_secondArray enumerateObjectsUsingBlock:^(LCAddressListDataModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.region_name isEqualToString:cityName]) {
                cityIndex = idx;
                *stop = YES;
            }
        }];
    } else {
        cityIndex = 0;
    }
    LCAddressListDataModel *firstCity = _secondArray[cityIndex];
    _thirdArray = [[LCDBManage sharedInstance] getCityDataFrom:firstCity.region_id];
    if (areaName.length > 0) {
        [_thirdArray enumerateObjectsUsingBlock:^(LCAddressListDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.region_name isEqualToString:areaName]) {
                areaIndex = idx;
                *stop = YES;
            }
        }];
    } else {
        areaIndex = 0;
    }
}

#pragma mark - button action
//点击确定按钮
- (void)pickerOKBtnAction:(UIButton *)btn {
    NSString *province = [self pickerView:_pickerView titleForRow:provinceIndex forComponent:0];
    NSString *city = [self pickerView:_pickerView titleForRow:cityIndex forComponent:1];
    NSString *area = [self pickerView:_pickerView titleForRow:areaIndex forComponent:2];
    [self deleteView];
    if (self.didSelectBlock) {
        self.didSelectBlock(province,city,area);
    }
    if (self.didSelectIndexBlock) {
        self.didSelectIndexBlock(provinceIndex, cityIndex, areaIndex);
    }
}

- (void)showView {
    [super showView];
    [_pickerView selectRow:provinceIndex inComponent:0 animated:NO];
    [_pickerView selectRow:cityIndex inComponent:1 animated:NO];
    [_pickerView selectRow:areaIndex inComponent:2 animated:NO];
}

#pragma mark - pickerView delegate && datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _firstArray.count;
    } else if (component == 1) {
        return _secondArray.count;
    } else {
        return _thirdArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    LCAddressListDataModel *model;
    if (component == 0) {
        model = _firstArray[row];
    } else if (component == 1) {
        model = _secondArray[row];
    } else {
        model = _thirdArray[row];
    }
    return model.region_name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    LCAddressListDataModel *model;
    if (component == 0) {
        model = _firstArray[row];
        _secondArray = [[LCDBManage sharedInstance] getCityDataFrom:model.region_id];
        LCAddressListDataModel *firstArea = _secondArray[0];
        _thirdArray = [[LCDBManage sharedInstance] getCityDataFrom:firstArea.region_id];
        [_pickerView selectRow:0 inComponent:1 animated:NO];
        [_pickerView selectRow:0 inComponent:2 animated:NO];
        provinceIndex = row;
    } else if (component == 1) {
        model = _secondArray[row];
        _thirdArray = [[LCDBManage sharedInstance] getCityDataFrom:model.region_id];
        [_pickerView selectRow:0 inComponent:2 animated:NO];
        cityIndex = row;
    } else {
        areaIndex = row;
    }
    [_pickerView reloadAllComponents];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    /*重新定义row 的UILabel*/
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.textColor = [UIColor colorWithRGB:0x333333];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setFont:[UIFont systemFontOfSize:14.0f]];
        pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    }
    return pickerLabel;
}

@end
