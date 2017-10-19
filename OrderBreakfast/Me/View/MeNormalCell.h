//
//  MeNormalCell.h
//  HeJing
//
//  Created by yaoyunheng on 2017/6/16.
//  Copyright © 2017年 GZLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeNormalCell : UITableViewCell

// 底部线
@property (nonatomic, strong) UIView *line;
// 右边箭头
@property (nonatomic, strong) UIImageView *arrowImgView;

- (void)configTitle:(NSString *)title content:(NSString *)content image:(NSString *)image;

@end
