//
//  LCLoadFailedTipsView.h
//
//  加载失败
//
//  Created by J on 16/8/3.
//  Copyright © 2016年 GZLC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LCLoadFailedTipsViewReloadBlock)(void);

@interface LCLoadFailedTipsView : UIView

//重新加载
@property (copy, nonatomic) LCLoadFailedTipsViewReloadBlock reloadBlock;

@end
