//
//  LCArrayPickerView.m
//  chubankuai
//
//  Created by old's mac on 2017/5/15.
//  Copyright © 2017年 gzlc. All rights reserved.
//

#import "LCArrayPickerView.h"

@interface LCArrayPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation LCArrayPickerView {
    NSInteger currentIndex;
}

- (instancetype)initWithArray:(NSArray *)dataArray {
    if (self = [super init]) {
        _dataArray = [NSMutableArray arrayWithArray:dataArray];
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        [self.pickerViewContainer addSubview:_pickerView];
        [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.pickerViewContainer);
            make.left.equalTo(self.pickerViewContainer).offset(20);
            make.right.equalTo(self.pickerViewContainer).offset(-20);
            make.bottom.equalTo(self.pickerViewContainer);
        }];
    }
    return self;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    currentIndex = selectedIndex;
    if (currentIndex >= 0) {
        [_pickerView selectRow:currentIndex inComponent:0 animated:NO];
    } else {
        [_pickerView selectRow:0 inComponent:0 animated:NO];
        currentIndex = 0;
    }
    [_pickerView reloadAllComponents];
}

#pragma mark - pickerView delegate && datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _dataArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    currentIndex = row;
    [_pickerView reloadComponent:component];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    /*重新定义row 的UILabel*/
    UILabel *pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setTextColor:[UIColor darkGrayColor]];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:20.0f]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    pickerLabel.textColor = [UIColor darkGrayColor];
    return pickerLabel;
}

#pragma mark - button action
//点击确定按钮
- (void)pickerOKBtnAction:(UIButton *)btn {
    [self deleteView];
    if (self.didSelectPayBlock) {
        self.didSelectPayBlock(_dataArray[currentIndex], currentIndex);
    }
}


@end
