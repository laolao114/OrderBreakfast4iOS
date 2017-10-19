//
//  LCTextView.m
//  chubankuai
//
//  Created by old's mac on 2017/5/18.
//  Copyright © 2017年 gzlc. All rights reserved.
//

#import "LCTextView.h"

@interface LCTextView () <UITextViewDelegate>

@property (nonatomic, strong) UILabel *placeHolderLabel;

@end

@implementation LCTextView {
    MASConstraint *constraint1;
}

- (instancetype)init {
    if (self = [super init]) {
        self.delegate = self;
        _placeHolderLabel = [[UILabel alloc]init];
        _placeHolderLabel.textColor = [UIColor colorWithRGB:0xcccccc];
        _placeHolderLabel.hidden = YES;
        [self addSubview:_placeHolderLabel];
        [_placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            constraint1 = make.left.equalTo(self).offset(8);
            make.top.equalTo(self).offset(8);
            make.right.equalTo(self).offset(-8);
        }];
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    _placeHolderLabel.hidden = NO;
    _placeHolderLabel.font = self.font;
    _placeHolderLabel.text = placeholder;
}

- (void)setPlaceHolderPadding:(CGFloat)placeHolderPadding {
    _placeHolderPadding = placeHolderPadding;
    [constraint1 deactivate];
    [_placeHolderLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(placeHolderPadding);
    }];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    if (text.length > 0) {
        _placeHolderLabel.hidden = YES;
        _placeHolderLabel.font = self.font;
        _placeHolderLabel.text = _placeholder;
    } else {
        _placeHolderLabel.hidden = NO;
        _placeHolderLabel.font = self.font;
        _placeHolderLabel.text = _placeholder;
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        _placeHolderLabel.hidden = YES;
    } else {
        _placeHolderLabel.hidden = NO;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (self.textFieldBlock) {
        return self.textFieldBlock(textView, text);
    } else {
        return YES;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (self.textFieldBeginEditBlock) {
        self.textFieldBeginEditBlock(textView);
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (self.textFieldEndEditBlock) {
        self.textFieldEndEditBlock(textView);
    }
}

@end
