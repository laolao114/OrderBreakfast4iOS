//
//  LCNoDataTipsCollectionViewCell.m
//  ShiJiaoSuo
//
//  Created by J on 16/8/3.
//  Copyright © 2016年 Guangzhou Shijiaosuo. All rights reserved.
//

#import "LCNoDataTipsCollectionViewCell.h"
#import "LCNoDataTipsView.h"

@interface LCNoDataTipsCollectionViewCell ()

//暂无内容提示
@property (weak, nonatomic) LCNoDataTipsView *noDataTipsView;

@end

@implementation LCNoDataTipsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
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
