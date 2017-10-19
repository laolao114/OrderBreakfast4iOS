//
//  CreateOrderAddressCell.m
//  chubankuai
//
//  Created by old's mac on 2017/5/27.
//  Copyright © 2017年 gzlc. All rights reserved.
//

#import "CreateOrderAddressCell.h"

@interface CreateOrderAddressCell ()

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@end

@implementation CreateOrderAddressCell {
    MASConstraint *constraint1;
    MASConstraint *constraint2;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    _tipLabel = [[UILabel alloc]init];
    _tipLabel.textColor = COLOR_TEXT_BLACK;
    _tipLabel.font = [UIFont systemFontOfSize:14];
    _tipLabel.text = @"选择收货地址";
    [self.contentView addSubview:_tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(16);
        constraint1 = make.bottom.equalTo(self.contentView).offset(-16).priority(502);
    }];
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textColor = COLOR_TEXT_LIGHT_BLACK;
    _nameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-30);
    }];
    _addressLabel = [[UILabel alloc]init];
    _addressLabel.textColor = COLOR_TEXT_LIGHT_BLACK;
    _addressLabel.numberOfLines = 0;
    _addressLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(_nameLabel.mas_bottom).offset(13);
        constraint2 = make.bottom.equalTo(self.contentView).offset(-16).priority(501);
        make.right.equalTo(self.contentView).offset(-30);
    }];
    UIImageView *_arrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_arrow"]];
    [self.contentView addSubview:_arrowView];
    [_arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.contentView);
    }];
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = COLOR_LINE_UNDER;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView);
        make.height.equalTo(@(ONE_PX));
    }];
}

- (void)configCellWithAddressModel:(id)addressModel {
    NSInteger height;
    BOOL status1 = NO;
    if (addressModel && [addressModel isKindOfClass:[MyAddressListModelData class]]) {
        MyAddressListModelData *data = (MyAddressListModelData *)addressModel;
        _tipLabel.hidden = YES;
        _nameLabel.hidden = NO;
        _addressLabel.hidden = NO;
        [constraint1 deactivate];
        [constraint2 activate];
        _nameLabel.text = [NSString stringWithFormat:@"%@ %@",data.name,data.phone];
        _addressLabel.text = [NSString stringWithFormat:@"地址：%@",data.address];
        status1 = YES;
    } else {
        _tipLabel.hidden = NO;
        _nameLabel.hidden = YES;
        _addressLabel.hidden = YES;
        [constraint2 deactivate];
        [constraint1 activate];
    }
    [self.contentView layoutIfNeeded];
    if (status1) {
        height = 16 * 2 + _nameLabel.frame.size.height + 13 + _addressLabel.frame.size.height;
    } else {
        height = 50;
    }
    if (self.cellHeightDidChange) {
        self.cellHeightDidChange(height);
    }
}

@end
