//
//  LCCustomPickerView.h
//  ShiJiaoSuo
//
//  pickerView 基础界面，并不包含 pickView，但有一个 pickerViewContainer，可自行创建 pickerView 放在 pickerViewContainer 里
//
//  Created by J on 16/5/27.
//  Copyright © 2016年 Guangzhou Shijiaosuo. All rights reserved.
//

#import <UIKit/UIKit.h>

//点击确定按钮之后
typedef void(^PickerOKBtnDidTapBlock)(void);

@interface LCCustomPickerView : UIView

// pickerView 容器
@property (weak, nonatomic) UIView *pickerViewContainer;

@property (strong, nonatomic) NSString *titleLabelStr;
@property (strong, nonatomic) NSString *pickerOKBtnStr;
@property (strong, nonatomic) NSString *pickerCancelBtnStr;

@property (copy, nonatomic) PickerOKBtnDidTapBlock okBtnDidTapBlock;

- (void)showView;
- (void)deleteView;

@end
