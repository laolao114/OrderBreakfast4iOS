//
//  OrderListCell.m
//  chubankuai
//
//  Created by old's mac on 2017/4/10.
//  Copyright © 2017年 gzlc. All rights reserved.
//

#import "OrderListCell.h"

@interface OrderListCell ()

@property (nonatomic, strong) UILabel *addressLabel;        // 地址
@property (nonatomic, strong) UILabel *priceLabel;          // 价格
@property (nonatomic, strong) UILabel *distanceLabel;       // 距离
@property (nonatomic, strong) UILabel *nameLabel;           // 事件名称
@property (nonatomic, strong) UILabel *timeLabel;           // 截止时间
@property (nonatomic, strong) UIImageView *iconView;        // 类型图标

@end

@implementation OrderListCell {
    UIView *line;
    UIImageView *_arrowView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _iconView = [[UIImageView alloc] init];
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.cornerRadius = 4;
        [self.contentView addSubview:_iconView];
        _iconView.backgroundColor = [UIColor grayColor];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@80);
            make.left.equalTo(self.contentView).offset(15);
            make.centerY.equalTo(self.contentView);
        }];
        [_iconView setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:17];
        _nameLabel.textColor = COLOR_TEXT_BLACK;
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_iconView.mas_right).offset(20);
            make.top.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
        }];
        
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = [UIFont systemFontOfSize:15];
        _addressLabel.textColor = COLOR_TEXT_LIGHT_BLACK;
        [self.contentView addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_nameLabel);
            make.top.equalTo(_nameLabel.mas_bottom).offset(10);
        }];
        
        _distanceLabel = [[UILabel alloc] init];
        _distanceLabel.font = [UIFont systemFontOfSize:12];
        _distanceLabel.textColor = COLOR_TEXT_GRAY;
        [self.contentView addSubview:_distanceLabel];
        [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_addressLabel);
            make.top.equalTo(_addressLabel.mas_bottom).offset(10);
        }];
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:16];
        _priceLabel.textColor = COLOR_RED;
        [self.contentView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLabel);
            make.top.equalTo(_distanceLabel.mas_bottom).offset(15);
            make.bottom.equalTo(self.contentView).offset(-15);
        }];
        
        UILabel *goButton = [[UILabel alloc] init];
//        [goButton setTitle:@"去帮忙" forState:UIControlStateNormal];
        goButton.text = @"去帮忙";
        goButton.textAlignment = NSTextAlignmentCenter;
        goButton.textColor = [UIColor whiteColor];
        goButton.font = [UIFont systemFontOfSize:14];
        goButton.backgroundColor = COLOR_BLUE;
        goButton.layer.masksToBounds = YES;
        goButton.layer.cornerRadius = 4;
        [self.contentView addSubview:goButton];
        [goButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_nameLabel);
            make.centerY.equalTo(_priceLabel);
            make.width.equalTo(@66);
            make.height.equalTo(@30);
        }];
        
        line = [[UIView alloc]init];
        line.backgroundColor = COLOR_LINE_UNDER;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView);
            make.height.equalTo(@(ONE_PX));
        }];
    }
    return self;
}

- (void)setNoLines:(BOOL)noLines {
    _noLines = noLines;
    if (noLines) {
        line.hidden = YES;
    } else {
        line.hidden = NO;
    }
}

- (void)setModel:(OrderListModelData *)model {
    NSString *typeString;
    switch (model.type.integerValue) {
        // 类型：1.早餐 2.午餐 3.晚餐 4.快递 5.其他
        case 1:{
            _iconView.image = [UIImage imageNamed:@"icon_breakfast"];
            typeString = @"早餐";
        }
            break;
        case 2:{
            _iconView.image = [UIImage imageNamed:@"icon_lunch"];
            typeString = @"午餐";
        }
            break;
        case 3:{
            _iconView.image = [UIImage imageNamed:@"icon_dinner"];
            typeString = @"晚餐";
        }
            break;
        case 4:{
            _iconView.image = [UIImage imageNamed:@"icon_express"];
            typeString = @"快递";
        }
            break;
        case 5:{
            _iconView.image = [UIImage imageNamed:@"icon_other"];
            typeString = @"其他";
        }
            break;
        default:
            break;
    }
    _nameLabel.text = model.order_name;
    _addressLabel.text = model.address;
    _distanceLabel.text = [NSString stringWithFormat:@"距离我%@ | %@",model.distance,typeString];
    _priceLabel.text = [NSString stringWithFormat:@"¥ %@",model.price];
}

@end
