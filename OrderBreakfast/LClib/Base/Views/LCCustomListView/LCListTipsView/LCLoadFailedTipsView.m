//
//  LCLoadFailedTipsView.m
//
//  Created by J on 16/8/3.
//  Copyright © 2016年 GZLC. All rights reserved.
//

#import "LCLoadFailedTipsView.h"

static CGFloat paddingLeft = 12;

@interface LCLoadFailedTipsView ()

@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *reloadBtn;

@end

@implementation LCLoadFailedTipsView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    _iconImgView = [UIImageView new];
    _iconImgView.image = [UIImage imageNamed:@"blank"];
    [self addSubview:_iconImgView];
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(140);
        make.centerX.equalTo(self);
    }];
    
    _descLabel = [UILabel new];
    _descLabel.text = @"网络已走丢，努力寻找中...";
    _descLabel.textColor = UIColorHex(0x666666);
    _descLabel.font = [UIFont systemFontOfSize:13];
    _descLabel.numberOfLines = 0;
    _descLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - paddingLeft * 2;
    _descLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_descLabel];
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImgView.mas_bottom).offset(15);
        make.left.equalTo(self).offset(paddingLeft);
        make.right.equalTo(self).offset(-paddingLeft);
    }];
    
    _reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _reloadBtn.layer.borderWidth = ONE_PX;
    _reloadBtn.layer.borderColor = COLOR_BLUE.CGColor;
    _reloadBtn.layer.masksToBounds = YES;
    _reloadBtn.layer.cornerRadius  = 1;
    _reloadBtn.titleLabel.font     = [UIFont systemFontOfSize:14];
//    [_reloadBtn addTarget:self action:@selector(reloadBtnTouchDown:) forControlEvents:UIControlEventTouchUpInside];
    [_reloadBtn addTarget:self action:@selector(reloadBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [_reloadBtn addTarget:self action:@selector(reloadBtnTouchUpOutsideAction:) forControlEvents:UIControlEventTouchUpOutside];
    [_reloadBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [_reloadBtn setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
    [_reloadBtn setTitleColor:COLOR_BLUE_HIGHLIGHTED forState:UIControlStateHighlighted];
    [self addSubview:_reloadBtn];
    [_reloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_descLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self);
        make.width.equalTo(@70);
        make.height.equalTo(@30);
    }];
}

- (void)reloadBtnAction:(UIButton *)btn {
//    btn.layer.borderColor = COLOR_TEXT_GRAY.CGColor;
    
    if (_reloadBlock) {
        _reloadBlock();
    }
}

//- (void)reloadBtnTouchDown:(UIButton *)btn {
//    btn.layer.borderColor = COLOR_TEXT_GRAY.CGColor;
//}

//- (void)reloadBtnTouchUpOutsideAction:(UIButton *)btn {
//    btn.layer.borderColor = COLOR_TEXT_GRAY.CGColor;
//}


@end
