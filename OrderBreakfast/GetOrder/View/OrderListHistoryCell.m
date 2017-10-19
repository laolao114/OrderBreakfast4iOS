//
//  OrderListHistoryCell.m
//  chubankuai
//
//  Created by old's mac on 2017/6/5.
//  Copyright © 2017年 gzlc. All rights reserved.
//

#import "OrderListHistoryCell.h"

@interface OrderListHistoryCell ()

@property (nonatomic, strong) UILabel *numberLabel;     // 项目名称
@property (nonatomic, strong) UILabel *countLabel;      // 订单名称
@property (nonatomic, strong) UILabel *statusLabel;     // 状态

@end

@implementation OrderListHistoryCell {
    UIView *line;
    UIImageView *_arrowView;
    MASConstraint *constraint1;
    MASConstraint *constraint2;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.font = [UIFont systemFontOfSize:17];
        _numberLabel.textColor = COLOR_TEXT_BLACK;
        [self.contentView addSubview:_numberLabel];
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.top.equalTo(self.contentView).offset(21);
        }];
        _countLabel = [[UILabel alloc]init];
        _countLabel.font = [UIFont systemFontOfSize:12];
        _countLabel.textColor = COLOR_TEXT_GRAY;
        [self.contentView addSubview:_countLabel];
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_numberLabel);
            make.top.equalTo(_numberLabel.mas_bottom).offset(15);
            make.bottom.equalTo(self.contentView).offset(-21);
        }];
        _arrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_arrow"]];
        _arrowView.hidden = YES;
        [self.contentView addSubview:_arrowView];
        [_arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.contentView);
        }];
        _statusLabel = [[UILabel alloc]init];
        _statusLabel.text = @"制版中";
        _statusLabel.textColor = COLOR_BLUE;
        _statusLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_statusLabel];
        [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            constraint1 = make.right.equalTo(_arrowView.mas_left).offset(-10).priorityHigh();
            [constraint1 deactivate];
            constraint2 = make.right.equalTo(self.contentView).offset(-30);
            [constraint2 activate];
        }];
        line = [[UIView alloc]init];
        line.backgroundColor = COLOR_LINE_UNDER;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15);
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

- (void)setNeedsArrow:(BOOL)needsArrow {
    _needsArrow = needsArrow;
    if (needsArrow) {
        _arrowView.hidden = NO;
        [constraint2 deactivate];
        [constraint1 activate];
    } else {
        _arrowView.hidden = YES;
        [constraint1 deactivate];
        [constraint2 activate];
    }
}

/* 状态
 * 1-等待付款           2-工单返回          3-新增工单           4-前期设计
 * 5-图纸派送（客户确认） 6-发排              7-制版              8-准备配送
 * 9-配送中            10-工单完成          11-工单取消（客服）   12-工单支付失败
 */
- (void)setModel:(OrderListModelData *)model {
    
}

@end
