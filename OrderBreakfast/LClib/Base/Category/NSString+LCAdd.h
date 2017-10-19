//
//  NSString+LCAdd.h
//  Futures
//
//  Created by yaoyunheng on 2017/3/28.
//  Copyright © 2017年 yaoyunheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LCAdd)

/**
 *  验证字符串是否为空
 *
 *  @warning 空格字符串会被认为是空字符串
 *
 */
- (BOOL)isEmptyOrNull;

/**
 *  验证是否为有效邮箱
 */
- (BOOL)isValidateEmail;

/**
 *  验证是否为有效手机号码
 */
- (BOOL)isMobileNumber;

/**
 *  验证是否为有效身份证号码
 */
- (BOOL)isIdCard;

/**
 *  验证是否为纯数字
 */
- (BOOL)isAllNum;

/**
 *  身高正则判断

 *
 *  @return 是否符合规范`10-299.9`
 */
- (BOOL)isHeightFormat;

/**
 *  体重正则判断
 *
 *  @return 是否符合规范`10-999.99`
 */
- (BOOL)isWeightFormat;

#pragma mark - time
/**
 *  时间戳转换自定义时间格式
 *
 *  @return return value description
 */
- (NSString *)timeFormat;

/**
 *  时间戳转化统一格式
 *
 *  @param fomatString example : yyyy-MM-dd HH:mm:ss 年月日时分秒
 *
 *  @return return value description
 */
- (NSString *)timeFormatWithFomatString:(NSString *)fomatString;

/**
 *  将秒数转换成 时:分:秒，用于倒计时
 *
 *
 *  @return 时:分:秒
 */
- (NSString *)timeToCountdownTime;

@end
