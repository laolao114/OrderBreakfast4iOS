//
//  MeMainHeadView.m
//  OrderBreakfast
//
//  Created by old's mac on 2017/7/18.
//  Copyright © 2017年 scnu. All rights reserved.
//

#import "MeMainHeadView.h"

@interface MeMainHeadView ()

@property (nonatomic, strong) UIImageView *avatarImgView;
@property (nonatomic, strong) UILabel *nickLabel;
@property (nonatomic, strong) UILabel *phoneLabel;

@end

@implementation MeMainHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = COLOR_BLUE;
    _avatarImgView = [[UIImageView alloc] initWithImage:IMG_DEFAULT_AVATAR];
    _avatarImgView.layer.masksToBounds = YES;
    _avatarImgView.layer.cornerRadius = 25;
    [self addSubview:_avatarImgView];
    [_avatarImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.height.width.equalTo(@50);
        make.left.equalTo(self).offset(20);
    }];
    
    _nickLabel = [[UILabel alloc] init];
    _nickLabel.textColor = [UIColor whiteColor];
    _nickLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:_nickLabel];
    [_nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatarImgView.mas_right).offset(20).priorityMedium();
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(self);
    }];
    
    _phoneLabel = [[UILabel alloc] init];
    _phoneLabel.textColor = [UIColor whiteColor];
    _phoneLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickLabel.mas_bottom).offset(10);
        make.left.right.equalTo(_nickLabel);
    }];
}

- (void)configViewWith:(NSString *)avatarUrl andNick:(NSString *)nick andPhone:(NSString *)phone {
    [_avatarImgView sd_setImageWithURL:[NSURL URLWithString:avatarUrl] placeholderImage:IMG_DEFAULT_AVATAR];
    _nickLabel.text = nick;
    _phoneLabel.text = phone;
}

@end
