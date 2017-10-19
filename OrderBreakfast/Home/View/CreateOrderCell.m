//
//  CreateOrderCell.m
//  chubankuai
//
//  Created by old's mac on 2017/4/10.
//  Copyright © 2017年 gzlc. All rights reserved.
//

#import "CreateOrderCell.h"

@interface CreateOrderCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowView;

@end

@implementation CreateOrderCell {
    UIView *line;
    MASConstraint *needsArrowRightCon;
    MASConstraint *noArrowRightCon;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.userInteractionEnabled = YES;
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = COLOR_TEXT_BLACK;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(16);
            make.bottom.equalTo(self.contentView).offset(-16);
            make.left.equalTo(self.contentView).offset(15);
        }];
        [_titleLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        _arrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_arrow"]];
        [self.contentView addSubview:_arrowView];
        [_arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.contentView);
        }];
        [_arrowView setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        _textField = [[UITextField alloc]init];
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.textColor = COLOR_TEXT_LIGHT_BLACK;
        [self.contentView addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(_titleLabel.mas_right).offset(20);
            needsArrowRightCon = make.right.equalTo(_arrowView.mas_left).offset(-10).priority(502);
            noArrowRightCon = make.right.equalTo(self.contentView).offset(-15).priority(501);
            [noArrowRightCon deactivate];
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

- (void)setNeedsArrow:(BOOL)needsArrow {
    _needsArrow = needsArrow;
    if (needsArrow) {
        [needsArrowRightCon activate];
        [noArrowRightCon deactivate];
        _arrowView.hidden = NO;
        
    } else {
        [noArrowRightCon activate];
        [needsArrowRightCon deactivate];
        _arrowView.hidden = YES;
    }
}

- (void)setTextFieldCanEdit:(BOOL)textFieldCanEdit {
    _textFieldCanEdit = textFieldCanEdit;
    if (textFieldCanEdit) {
        _textField.enabled = YES;
    } else {
        _textField.enabled = NO;
    }
}

- (void)configCellWithTitle:(NSString *)title content:(id)content {
    _titleLabel.text = title;
    if ([content isKindOfClass:[NSString class]]) {
        _textField.text = content;
    }
}

@end
