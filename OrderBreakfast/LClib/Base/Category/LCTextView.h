//
//  LCTextView.h
//  chubankuai
//
//  Created by old's mac on 2017/5/18.
//  Copyright © 2017年 gzlc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCTextView : UITextView

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, assign) CGFloat placeHolderPadding;       // 默认是8
@property (nonatomic, copy) BOOL(^textFieldBlock)(UITextView *textView, NSString *text);
@property (nonatomic, copy) void(^textFieldBeginEditBlock)(UITextView *textView);
@property (nonatomic, copy) void(^textFieldEndEditBlock)(UITextView *textView);

@end
