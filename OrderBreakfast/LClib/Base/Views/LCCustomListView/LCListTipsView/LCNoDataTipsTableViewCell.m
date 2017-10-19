//
//  LCNoDataTipsTableViewCell.m
//
//  Created by J on 16/8/3.
//  Copyright © 2016年 GZLC. All rights reserved.
//

#import "LCNoDataTipsTableViewCell.h"
#import "LCNoDataTipsView.h"

@interface LCNoDataTipsTableViewCell ()

// 暂无内容提示
@property (weak, nonatomic) LCNoDataTipsView *noDataTipsView;

@end

@implementation LCNoDataTipsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}

- (void)setupView {
    LCNoDataTipsView *noDataTipsView = [LCNoDataTipsView new];
    [self.contentView addSubview:noDataTipsView];
    _noDataTipsView = noDataTipsView;
    _noDataTipsView.descStr = _noDataTipsViewDescStr.length > 0 ? _noDataTipsViewDescStr : NSLocalizedString(@"LCNoDataTipsView.descTxt", nil);
    [_noDataTipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(70);
        make.bottom.equalTo(self.contentView).offset(-70);
    }];
}

//自定义暂无内容提示文案
- (void)setNoDataTipsViewDescStr:(NSString *)noDataTipsViewDescStr {
    _noDataTipsViewDescStr = noDataTipsViewDescStr;
    
    if (_noDataTipsView) {
        _noDataTipsView.descStr = _noDataTipsViewDescStr;
    }
}

@end
