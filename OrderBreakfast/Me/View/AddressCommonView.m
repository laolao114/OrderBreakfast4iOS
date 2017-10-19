//
//  AddressCommonView.m
//  HeJing
//
//  Created by old's mac on 2017/7/4.
//  Copyright © 2017年 GZLC. All rights reserved.
//

#import "AddressCommonView.h"

@interface AddressCommonView()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *phoneLabel;

@end

@implementation AddressCommonView

- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    _phoneLabel = [[UILabel alloc]init];
    _phoneLabel.font = [UIFont systemFontOfSize:15];
    _phoneLabel.textColor = COLOR_TEXT_BLACK;
    [self addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(15);
    }];
    [_phoneLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [_phoneLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];

    UILabel *tipNameLabel = [[UILabel alloc]init];
    tipNameLabel.font = [UIFont systemFontOfSize:15];
    tipNameLabel.textColor = COLOR_TEXT_BLACK;
    tipNameLabel.text = @"收货人：";
    [self addSubview:tipNameLabel];
    [tipNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(15);
    }];
    [tipNameLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [tipNameLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = COLOR_TEXT_BLACK;
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tipNameLabel.mas_right);
        make.top.equalTo(tipNameLabel);
        make.right.equalTo(_phoneLabel.mas_left).offset(-10);
    }];
    
//    UILabel *tipAddressLabel= [[UILabel alloc]init];
//    tipAddressLabel.font = [UIFont systemFontOfSize:15];
//    tipAddressLabel.textColor = COLOR_TEXT_BLACK;
//    tipAddressLabel.text = @"收货地址：";
//    [self addSubview:tipAddressLabel];
//    [tipAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(tipNameLabel);
//        make.top.equalTo(_nameLabel.mas_bottom).offset(15);
//    }];
//    [tipAddressLabel setContentCompressionResistancePriority:752 forAxis:UILayoutConstraintAxisHorizontal];
//    [tipAddressLabel setContentHuggingPriority:752 forAxis:UILayoutConstraintAxisHorizontal];
    
    _addressLabel = [[UILabel alloc]init];
    _addressLabel.font = [UIFont systemFontOfSize:15];
    _addressLabel.textColor = COLOR_TEXT_BLACK;
    _addressLabel.numberOfLines = 0;
    [self addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(tipAddressLabel.mas_right);
//        make.top.equalTo(tipAddressLabel);
        make.left.equalTo(tipNameLabel);
        make.top.equalTo(_nameLabel.mas_bottom).offset(15);
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-15);
    }];
}

- (void)configViewWith:(NSString *)name andPhone:(NSString *)phone andAddress:(NSString *)address {
    _nameLabel.text = name;
    _phoneLabel.text = phone;
    _addressLabel.text = [NSString stringWithFormat:@"收货地址：%@",address];
}

@end
