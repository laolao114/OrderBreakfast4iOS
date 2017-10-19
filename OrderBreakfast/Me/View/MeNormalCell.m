//
//  MeNormalCell.m
//  HeJing
//
//  Created by yaoyunheng on 2017/6/16.
//  Copyright © 2017年 GZLC. All rights reserved.
//

#import "MeNormalCell.h"

@interface MeNormalCell ()

// 左边图标
@property (nonatomic, strong) UIImageView *leftImageView;
// 左边标题
@property (nonatomic, strong) UILabel *titleLabel;
// 右边内容
@property (nonatomic, strong) UILabel *contentLabel;


@end

@implementation MeNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _leftImageView = [UIImageView new];
    [self.contentView addSubview:_leftImageView];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(50);
        make.centerY.equalTo(self.contentView);
    }];
    
    _arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_grey"]];
    [self.contentView addSubview:_arrowImgView];
    [_arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.contentView);
    }];

    _contentLabel = [UILabel new];
    _contentLabel.textColor = [UIColor grayColor];
    _contentLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_arrowImgView.mas_left).offset(-10);
        make.centerY.equalTo(self.contentView);
    }];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = COLOR_LINE_SEPARATE;
    [self.contentView addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@(ONE_PX));
    }];

}

- (void)configTitle:(NSString *)title content:(NSString *)content image:(NSString *)image {
    if (title) {
        _titleLabel.text = title;
    }
    
    if (content) {
        _contentLabel.text = content;
    }
    
    if (image) {
        _leftImageView.image = [UIImage imageNamed:image];
        
        [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(50);
        }];
        
    } else {
        _leftImageView.image = nil;
        
        [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
        }];
    }
}

@end
