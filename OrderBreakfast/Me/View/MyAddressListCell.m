//
//  MyAddressListCell.m
//  HeJing
//
//  Created by old's mac on 2017/7/5.
//  Copyright © 2017年 GZLC. All rights reserved.
//

#import "MyAddressListCell.h"
#import "AddressCommonView.h"

@interface MyAddressListCell ()

@property (nonatomic, strong) AddressCommonView *addressView;
@property (nonatomic, strong) UIButton *editButton;

@end

@implementation MyAddressListCell {
    UIView *_line;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    _addressView = [[AddressCommonView alloc]init];
    [self.contentView addSubview:_addressView];
    [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-30);
    }];
    
    _editButton = [[UIButton alloc] init];
    [_editButton addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
//    _editButton = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_Feedback"]];
//    _editButton.backgroundColor = COLOR_ORANGE;
//    _editButton.hidden = YES;
    [_editButton setImage:[UIImage imageNamed:@"icon_Feedback"] forState:UIControlStateNormal];
    [self.contentView addSubview:_editButton];
    [_editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-9);
        make.centerY.equalTo(self.contentView);
    }];

    _line = [[UIView alloc]init];
    _line.backgroundColor = COLOR_LINE_SEPARATE;
    [self.contentView addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@(ONE_PX));
    }];
}

- (void)setNoLine:(BOOL)noLine {
    _noLine = noLine;
    _line.hidden = noLine;
}

- (void)editAction:(UIButton *)editButton {
    if (self.didEditBlock) {
        self.didEditBlock();
    }
}

- (void)configCellWith:(MyAddressListModelData *)data andIsSelected:(BOOL)isSelected {
    NSString *addressString = [NSString stringWithFormat:@"%@ %@ %@ %@",data.province,data.city,data.area,data.address];
    [_addressView configViewWith:data.name andPhone:data.phone andAddress:addressString];
//    _editButton.hidden = !isSelected;
}

@end
