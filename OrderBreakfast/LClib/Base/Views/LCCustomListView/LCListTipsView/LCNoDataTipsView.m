//
//  LCNoDataTipsView.m
//
//  Created by J on 16/8/3.
//  Copyright © 2016年 GZLC. All rights reserved.
//

#import "LCNoDataTipsView.h"

static CGFloat paddingLeft = 12;

@interface LCNoDataTipsView ()

@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation LCNoDataTipsView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.userInteractionEnabled = NO;
    
    _iconImgView = [UIImageView new];
    _iconImgView.image = [UIImage imageNamed:@"blank"];
    [self addSubview:_iconImgView];
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(140);
        make.centerX.equalTo(self);
    }];
    
    _descLabel = [UILabel new];
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
    
    self.descStr = @"";
}

- (void)setDescStr:(NSString *)descStr {
    _descStr = descStr;
    
    if (_descStr.length > 0) {
        _descLabel.text = _descStr;
    } else {
        _descLabel.text = @"暂时没有数据";
    }
}

- (void)setImage:(UIImage *)image {
    _image = image;
    if (_image && _iconImgView) {
        _iconImgView.image = image;
    }
}

@end
