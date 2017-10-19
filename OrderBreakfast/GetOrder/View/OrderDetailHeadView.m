//
//  OrderDetailHeadView.m
//  OrderBreakfast
//
//  Created by old's mac on 2017/9/10.
//  Copyright © 2017年 scnu. All rights reserved.
//

#import "OrderDetailHeadView.h"

@interface OrderDetailHeadView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *helperView;
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation OrderDetailHeadView

- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = COLOR_BACKGROUND_GRAY;
    
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor whiteColor];
    [self addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
    }];
    
    _titleLabel = [[UILabel alloc] init];
    [headView addSubview:_titleLabel];
    _titleLabel.font = [UIFont boldSystemFontOfSize:20];
    _titleLabel.textColor = COLOR_TEXT_BLACK;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView);
        make.top.equalTo(headView).offset(40);
        make.bottom.equalTo(headView).offset(-15);
    }];
    [self createHeadViewWithTagView:headView andTitle:@"任务状态" andTag:0];
    
    _helperView = [[UILabel alloc] init];
    [self addSubview:_helperView];
    _helperView.backgroundColor = [UIColor whiteColor];
    [_helperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(headView.mas_bottom).offset(10);
    }];
    
    [self createHeadViewWithTagView:_helperView andTitle:@"求助人信息" andTag:1];
    
    _avatarView = [[UIImageView alloc] initWithImage:IMG_DEFAULT_AVATAR];
    [_helperView addSubview:_avatarView];
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@50);
        make.top.equalTo(_helperView).offset(40);
        make.bottom.equalTo(_helperView).offset(-15);
        make.left.equalTo(_helperView).offset(20);
    }];
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textColor = COLOR_TEXT_BLACK;
    _nameLabel.font = [UIFont boldSystemFontOfSize:16];
    [_helperView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatarView.mas_right).offset(20);
        make.top.equalTo(_avatarView);
    }];
    
    _addressLabel = [[UILabel alloc] init];
    _addressLabel.textColor = COLOR_TEXT_LIGHT_BLACK;
    _addressLabel.font = [UIFont systemFontOfSize:15];
    [_helperView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.mas_bottom).offset(10);
        make.bottom.lessThanOrEqualTo(_helperView).offset(-20);
    }];
    
    UIView *payView = [[UIView alloc] init];
    payView.backgroundColor = [UIColor whiteColor];
    [self addSubview:payView];
    [payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_helperView.mas_bottom).offset(10);
        make.left.right.equalTo(self);
    }];
    [self createHeadViewWithTagView:payView andTitle:@"酬劳" andTag:2];
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = COLOR_RED;
    _priceLabel.font = [UIFont systemFontOfSize:15];
    [payView addSubview:_priceLabel];
    UIView *titleView = [self viewWithTag:2];
    [titleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(payView).offset(-10);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(payView).offset(65);
        make.centerY.equalTo(titleView);
    }];

    
    UIView *infoView = [[UIView alloc] init];
    infoView.backgroundColor = [UIColor whiteColor];
    [self addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(payView.mas_bottom).offset(10);
        make.bottom.equalTo(self);
    }];
    
    [self createHeadViewWithTagView:infoView andTitle:@"求助内容" andTag:3];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.numberOfLines = 0;
    [infoView addSubview:_contentLabel];
    _contentLabel.textColor = COLOR_TEXT_BLACK;
    _contentLabel.font = [UIFont systemFontOfSize:15];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView).offset(15);
        make.right.equalTo(infoView).offset(-15);
        make.top.equalTo(infoView).offset(40);
        make.bottom.equalTo(infoView).offset(-15);
    }];
}

- (void)configViewWith:(OrderDetailModelData *)data {
    switch (data.status.integerValue) {
        case 0: {
            _titleLabel.text = @"未完成";
        }
            break;
            
        default:
            break;
    }
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:data.avatarUrl] placeholderImage:IMG_DEFAULT_AVATAR];
    _nameLabel.text = data.name;
    _contentLabel.text = data.content;
    _priceLabel.text = [NSString stringWithFormat:@"%@元",data.price];
    _addressLabel.text = data.address;
}

- (void)createHeadViewWithTagView:(UIView *)superView andTitle:(NSString *)title andTag:(NSInteger)tag {
    UIView *lineView = [[UIView alloc] init];
    [superView addSubview:lineView];
    lineView.backgroundColor = COLOR_BLUE;
    lineView.tag = tag;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.top.equalTo(superView).offset(10);
        make.width.equalTo(@5);
        make.height.equalTo(@15);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = COLOR_TEXT_BLACK;
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.text = title;
    [superView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineView);
        make.left.equalTo(lineView.mas_right).offset(10);
    }];
}

@end

