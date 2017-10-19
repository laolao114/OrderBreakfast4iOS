//
//  LCCustomPickerView.m
//  ShiJiaoSuo
//
//  Created by J on 16/5/27.
//  Copyright © 2016年 Guangzhou Shijiaosuo. All rights reserved.
//

#import "LCCustomPickerView.h"

static CGFloat pickerTitleHeight = 50;
static CGFloat pickerHeight = 200;

@interface LCCustomPickerView ()

//遮罩
@property (weak, nonatomic) UIView *maskView;
//标题栏
@property (weak, nonatomic) UIView *titleView;
@property (weak, nonatomic) UILabel *titleLabel;
//操作栏，放置按钮
@property (weak, nonatomic) UIView *actionView;
//确定按钮
@property (weak, nonatomic) UIButton *pickerOKBtn;
//取消按钮
@property (weak, nonatomic) UIButton *pickerCancelBtn;

@end

@implementation LCCustomPickerView {
    UIWindow *window;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        window = [UIApplication sharedApplication].keyWindow;
        [self setupPicker];
    }
    return self;
}

- (void)setupPicker {
    [window addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    
    UIView *maskView = [UIView new];
    _maskView = maskView;
    _maskView.backgroundColor = [UIColor colorWithRGB:0x000000 alpha:0.75];
    [self addSubview:_maskView];
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    
    _maskView.userInteractionEnabled = YES;
    UITapGestureRecognizer *maskViewTap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [self deleteView];
        
    }];
    [_maskView addGestureRecognizer:maskViewTap];
    
    UIView *pickerViewContainer = [UIView new];
    _pickerViewContainer = pickerViewContainer;
    _pickerViewContainer.backgroundColor = COLOR_BACKGROUND_GRAY;
    [self addSubview:_pickerViewContainer];
    [_pickerViewContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(pickerHeight));
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(pickerHeight + pickerTitleHeight * 2);
    }];
    
    //操作栏
    UIView *actionView = [UIView new];
    _actionView = actionView;
    [self addSubview:actionView];
    _actionView.backgroundColor = [UIColor whiteColor];
    [_actionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(pickerTitleHeight));
        make.left.right.equalTo(_pickerViewContainer);
        make.bottom.equalTo(_pickerViewContainer.mas_top);
    }];
        
    UIButton *pickerOKBtn = [self createPublicButton:@"确定" target:_actionView];
    _pickerOKBtn = pickerOKBtn;
    [_pickerOKBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_actionView);
        make.right.top.bottom.equalTo(actionView);
        make.width.equalTo(@60);
    }];
    [_pickerOKBtn addTarget:self action:@selector(pickerOKBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *pickerCancelBtn = [self createPublicButton:@"取消" target:_actionView];
    _pickerCancelBtn = pickerCancelBtn;
    [_pickerCancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(_actionView);
        make.centerY.equalTo(_actionView);
        make.width.equalTo(@60);
    }];
    [_pickerCancelBtn addTarget:self action:@selector(pickerCancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //标题栏
//    UIView *titleView = [UIView new];
//    _titleView = titleView;
//    [self addSubview:titleView];
//    _titleView.hidden = YES;
//    _titleView.backgroundColor = [UIColor colorWithRGB:0x0a091b];
//    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@(pickerTitleHeight));
//        make.left.right.equalTo(_pickerViewContainer);
//        make.bottom.equalTo(_actionView.mas_top);
//    }];
    
    UILabel *titleLabel = [UILabel new];
    _titleLabel = titleLabel;
    [_actionView addSubview:_titleLabel];
    _titleLabel.font = [UIFont systemFontOfSize:18];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(actionView);
    }];
    [self layoutIfNeeded];
}

//显示
- (void)showView {
    [_pickerViewContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(0);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

//隐藏
- (void)deleteView {
    [_pickerViewContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(pickerHeight + pickerTitleHeight * 2);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//设置标题
- (void)setTitleLabelStr:(NSString *)titleLabelStr {
    _titleLabelStr = titleLabelStr;
    if (_titleLabelStr.length == 0) {
//        _titleView.hidden = YES;
    } else {
//        _titleView.hidden = NO;
        _titleLabel.text = _titleLabelStr;
    }
}

//设置确定按钮文字
- (void)setPickerOKBtnStr:(NSString *)pickerOKBtnStr {
    _pickerOKBtnStr = pickerOKBtnStr;
    [_pickerOKBtn setTitle:_pickerOKBtnStr forState:UIControlStateNormal];
}

//点击确定按钮
- (void)pickerOKBtnAction:(UIButton *)btn {
    [self deleteView];
    
    if (_okBtnDidTapBlock) {
        _okBtnDidTapBlock();
    }
}

//设置取消按钮文字
- (void)setPickerCancelBtnStr:(NSString *)pickerCancelBtnStr {
    _pickerCancelBtnStr = pickerCancelBtnStr;
    
    if (_pickerCancelBtnStr.length == 0) {
        _pickerCancelBtn.hidden = YES;
    } else {
        _pickerCancelBtn.hidden = NO;
        [_pickerCancelBtn setTitle:_pickerCancelBtnStr forState:UIControlStateNormal];
    }
}

//点击取消按钮
- (void)pickerCancelBtnAction:(UIButton *)btn {
    [self deleteView];
}

//生成公用按钮
- (UIButton *)createPublicButton:(NSString *)title target:(UIView *)target {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]; 
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [target addSubview:btn];
    
    return btn;
}

@end
