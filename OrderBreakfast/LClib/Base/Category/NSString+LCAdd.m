//
//  NSString+LCAdd.m
//  Futures
//
//  Created by yaoyunheng on 2017/3/28.
//  Copyright © 2017年 yaoyunheng. All rights reserved.
//

#import "NSString+LCAdd.h"

@implementation NSString (LCAdd)

- (BOOL)isEmptyOrNull {
    if (self == nil) {
        return YES;
    }
    if ([self isEqualToString:@""]) {
        return YES;
    }
    if (self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

- (BOOL)isValidateEmail {
    if ([self isEmptyOrNull])
    {
        return NO;
    }
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isMobileNumber {
    if ([self isEmptyOrNull])
    {
        return NO;
    }
    
    //#warning 暂时把手机号码判断简单处理，主要判断交给服务端
    if ([self isAllNum])
        return YES;
    else
        return NO;
    
    //    if (self.length == 11 && [[self substringToIndex:1] isEqualToString:@"1"]) {
    //        return YES;
    //    } else {
    //        return NO;
    //    }
    
    //    /**
    //     * 手机号码
    //     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
    //     * 联通：130,131,132,152,155,156,185,186
    //     * 电信：133,1349,153,180,189
    //     */
    //    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    //
    //    /**
    //     10         * 中国移动：China Mobile
    //     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
    //     12         */
    //    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    //
    //    /**
    //     15         * 中国联通：China Unicom
    //     16         * 130,131,132,152,155,156,185,186
    //     17         */
    //    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    //
    //    /**
    //     20         * 中国电信：China Telecom
    //     21         * 133,1349,153,180,181,189
    //     22         */
    //    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    //
    //    /**
    //     25         * 大陆地区固话及小灵通
    //     26         * 区号：010,020,021,022,023,024,025,027,028,029
    //     27         * 号码：七位或八位
    //     28         */
    //    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    //
    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    //
    //    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    //
    //    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    //
    //    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    //
    //    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    //
    //
    //    if (([regextestmobile evaluateWithObject:self] == YES)
    //
    //        || ([regextestcm evaluateWithObject:self] == YES)
    //
    //        || ([regextestct evaluateWithObject:self] == YES)
    //
    //        || ([regextestcu evaluateWithObject:self] == YES)
    //
    //        || ([regextestphs evaluateWithObject:self] == YES))
    //
    //    {
    //        return YES;
    //    }
    //    else
    //    {
    //        return NO;
    //    }
}

- (BOOL)isIdCard {
    if ([self isEmptyOrNull]) {
        return NO;
    }
    // 判断位数
    if ([self length] < 15 ||[self length] > 18) {
        return NO;
    }
    NSString *carid = self;
    long lSumQT =0;
    // 加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    // 校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    // 将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:self];
    if ([self length] == 15) {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        for (int i = 0; i <= 16; i++) {
            p += (pid[i] - 48) * R[i];
        }
        int o = p % 11;
        NSString *string_content = [NSString stringWithFormat:@"%c", sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    // 判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![sProvince areaCode]) {
        return NO;
    }
    // 判断年月日是否有效
    
    // 年份
    int strYear = [[carid substringWithRange:NSMakeRange(6, 4)]intValue];
    // 月份
    int strMonth = [[carid substringWithRange:NSMakeRange(10, 2)]intValue];
    // 日
    int strDay = [[carid substringWithRange:NSMakeRange(12, 2)]intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01", strYear, strMonth, strDay]];
    if (date == nil) {
        return NO;
    }
    const char *PaperId  = [carid UTF8String];
    
    // 检验长度
    if( 18 != strlen(PaperId)) return - 1;
    // 校验数字
    for (int i = 0; i < 18; i++) {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) ) {
            return NO;
        }
    }
    // 验证最末的校验码
    for (int i = 0; i <= 16; i++) {
        lSumQT += (PaperId[i] - 48) * R[i];
    }
    if (sChecker[lSumQT % 11] != PaperId[17] ) {
        return NO;
    }
    return YES;
}

- (BOOL)areaCode {
    if ([self isEmptyOrNull]) {
        return NO;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:self] == nil) {
        return NO;
    }
    return YES;
}

- (BOOL)isAllNum {
    unichar c;
    for (int i = 0; i < self.length; i++) {
        c = [self characterAtIndex:i];
        if (!isdigit(c)) {  
            return NO;
        }
    }
    return YES;
}

#pragma mark 身高体重正则判断

/**
 *  身高正则判断
 *
 *  @return 是否符合规范`10-299.9`
 */
- (BOOL)isHeightFormat {
    NSRegularExpression *regular = [[NSRegularExpression alloc]
                                    initWithPattern:@"^[12]\\d{2}(\\.\\d)?|[1-9]\\d(\\.\\d)?$"
                                    options:NSRegularExpressionCaseInsensitive
                                    error:nil];
    NSArray<NSTextCheckingResult *> *results =
    [regular matchesInString:self
                     options:0
                       range:NSMakeRange(0, self.length)];
    if ([self isEqualToString:[self substringWithRange:results.firstObject
                               .range]]) {
        return YES;
    } else {
        return NO;
    }
}

/**
 *  体重正则判断
 *
 *
 *  @return 是否符合规范`10-999.99`
 */
- (BOOL)isWeightFormat {
    NSRegularExpression *regular = [[NSRegularExpression alloc]
                                    initWithPattern:@"^[1-9]\\d{1,2}(\\.\\d{1,2})?$"
                                    options:NSRegularExpressionCaseInsensitive
                                    error:nil];
    NSArray<NSTextCheckingResult *> *results =
    [regular matchesInString:self
                     options:0
                       range:NSMakeRange(0, self.length)];
    if ([self isEqualToString:[self substringWithRange:results.firstObject
                               .range]]) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - time
- (NSString *)timeFormat {
    NSNumber *timeObj = [self numberValue];
    double doubleTime = [timeObj doubleValue];
    // 如果转换时间成功
    if (doubleTime !=  0) {
        double currentTime = [[LCNetworkHelper sharedInstance] getRequestTime];
        double spaceTime = currentTime - doubleTime;
        if (spaceTime < 0) {
            return [self timeFormatWithFomatString:@"yyyy-MM-dd"];
        } else {
            if (spaceTime < 60) {
                // 60秒前
                return @"刚刚";
            } else {
                if (spaceTime < 3600){
                    return [NSString stringWithFormat:@"%d分钟前", (int)floor(spaceTime/60)];
                } else {
                    if (spaceTime < 86400){
                        return [NSString stringWithFormat:@"%d小时前", (int)floor(spaceTime/3600)];
                    } else {
                        if (spaceTime < 259200){
                            // 3天内
                            return [NSString stringWithFormat:@"%d天前", (int)floor(spaceTime/86400)];
                        } else {
                            return [self timeFormatWithFomatString:@"yyyy-MM-dd"];
                        }
                    }
                }
            }
        }
    } else {
        // 不成功直接返回
        return self;
    }
}

- (NSString *)timeFormatWithFomatString:(NSString *)fomatString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:fomatString];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}


- (NSString *)timeToCountdownTime {
    NSTimeInterval time = [self doubleValue];
    NSInteger day = time / (24 * 60 * 60);
    NSInteger hours = (int)(time / (60 * 60)) % 24;
    NSInteger minutes = (int)(time / 60) % 60;
    NSInteger seconds = (int)time % 60;
//    NSLog(@"将秒数转换成 时:分:秒，用于倒计时 - time:%f, day:%li, hours:%li, min:%li, sec:%li", time, (long)day, (long)hours, (long)minutes,(long)seconds);
    return [NSString stringWithFormat:@"%02li:%02li:%02li", (long)(day * 24 + hours), (long)minutes, (long)seconds];
}

@end
