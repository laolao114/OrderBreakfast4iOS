//
//  LCAccount.m
//
//  Created by yaoyunheng on 2016/10/17.
//  Copyright © 2016年 GZLC. All rights reserved.
//
 
#import "LCAccount.h"

// 如果退出登录需要清掉的数据,带上 lc_ 这个前缀
static NSString *const loginedKey       = @"lc_logined";// 是否登录
static NSString *const isFirstLoginKey  = @"lc_isFirstLogin"; // 是否第一次登录
static NSString *const deviceTokenKey   = @"deviceToken";// 设备令牌
static NSString *const sessionIdKey     = @"sessionId";//  身份识别
static NSString *const recieveNotifyKey = @"lc_recieveNotifyKey";
static NSString *const is_changeKey     = @"is_changeKey";
static NSString *const nickKey          = @"lc_nickKey";
static NSString *const faceKey          = @"lc_faceKey";
static NSString *const c_idKey          = @"lc_c_idKey";
static NSString *const activateTimeKey  = @"activateTimeKey";
static NSString *const unreadCountKey   = @"lc_unreadCountKey";
static NSString *const downloadPageKey  = @"downloadPageKey";
static NSString *const haveUnreadCountKey   = @"lc_haveUnreadCountKey";
static NSString *const currentAuctionMessageCountKey  = @"lc_currentAuctionMessageCountKey";
static NSString *const haveCurrentAuctionMessageCountKey  = @"lc_haveCurrentAuctionMessageCountKey";

#define GET_USER_DEFAULTS(v) NSUserDefaults *v = [NSUserDefaults standardUserDefaults];
#define ProfileName @"Profile"

@interface LCAccount ()<NSXMLParserDelegate>

@end

@implementation LCAccount

+ (instancetype)sharedInstance {
    static id _shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[LCAccount alloc]init];
    });
    return _shareInstance;
}

#pragma mark- setting method
- (void)setIsFirstLogin:(BOOL)isFirstLogin {
    [self setObject:@(isFirstLogin) forKey:isFirstLoginKey];
}

- (void)setLogined:(BOOL)logined {
    [self setObject:@(logined) forKey:loginedKey];
}

- (void)setDeviceToken:(NSString *)deviceToken {
    [self setObject:deviceToken forKey:deviceTokenKey];
}

- (void)setSessionId:(NSString *)sessionId {
    [self setObject:sessionId forKey:sessionIdKey];
}

- (void)setRecieveNotify:(NSArray *)recieveNotify {
    [self setObject:recieveNotify forKey:recieveNotifyKey];
}

- (void)setUserInfo:(LCUserProfileModel *)userInfo {
    [self cacheUserProfile:userInfo];
}

//唯一标识现在改为用户uid
- (void)setC_id:(NSString *)c_id {
    [self setObject:c_id forKey:c_idKey];
    LCUserProfileModel *item = [[LCUserProfileModel alloc]init];
    [self cacheUserProfile:item];
}

- (void)setIs_change:(BOOL)is_change {
    [self setObject:@(is_change) forKey:is_changeKey];
}

- (void)setNick:(NSString *)nick {
    [self setObject:nick forKey:nickKey];
}

- (void)setFace:(NSString *)face {
    [self setObject:face forKey:faceKey];
}

- (void)setActivateTime:(NSInteger)activateTime {
    [self setObject:@(activateTime) forKey:activateTimeKey];
}

- (void)setUnreadCount:(NSInteger)unreadCount {
    [self setObject:@(unreadCount) forKey:unreadCountKey];
}

- (void)setHaveUnreadCount:(BOOL)haveUnreadCount {
    [self setObject:@(haveUnreadCount) forKey:haveUnreadCountKey];
}

- (void)setCurrentAuctionMessageCount:(NSInteger)currentAuctionMessageCount {
    [self setObject:@(currentAuctionMessageCount) forKey:currentAuctionMessageCountKey];
}

- (void)setHaveCurrentAuctionMessageCount:(BOOL)haveCurrentAuctionMessageCount {
    [self setObject:@(haveCurrentAuctionMessageCount) forKey:haveCurrentAuctionMessageCountKey];
}

- (void)setDownloadPage:(NSString *)downloadPage {
    [self setObject:downloadPage forKey:downloadPageKey];
}

#pragma mark- getting method
- (BOOL)isFirstLogin {
    NSNumber *num = [self getObjectWithKey:isFirstLoginKey];
    return num.boolValue;
}

- (BOOL)logined {
    NSNumber *num = [self getObjectWithKey:loginedKey];
    return num.boolValue;
}

- (NSString *)deviceToken {
    return [self getObjectWithKey:deviceTokenKey];
}

- (NSString *)sessionId {
    return [self getObjectWithKey:sessionIdKey];
}

- (NSString *)c_id {
    return [self getObjectWithKey:c_idKey];;
}

- (BOOL)is_change{
    NSNumber *change = [self getObjectWithKey:is_changeKey];
    return change.boolValue;
}

- (NSString *)nick {
    return [self getObjectWithKey:nickKey];
}

- (NSString *)face {
    return [self getObjectWithKey:faceKey];
}

- (NSInteger)activateTime {
    return [[self getObjectWithKey:activateTimeKey] integerValue];
}

- (NSInteger)unreadCount {
    return [[self getObjectWithKey:unreadCountKey] integerValue];
}

- (BOOL)haveUnreadCount {
    NSNumber *num = [self getObjectWithKey:haveUnreadCountKey];
    return num.boolValue;
}

- (NSInteger)currentAuctionMessageCount {
    return [[self getObjectWithKey:currentAuctionMessageCountKey] integerValue];
}

- (BOOL)haveCurrentAuctionMessageCount {
    NSNumber *num = [self getObjectWithKey:haveCurrentAuctionMessageCountKey];
    return num.boolValue;
}

- (NSString *)downloadPage {
    return [self getObjectWithKey:downloadPageKey];
}

- (LCUserProfileModel *)userInfo {
    NSString *path = [self getFilePath];
    LCUserProfileModel *model_ = [NSKeyedUnarchiver unarchiveObjectWithFile:[path stringByAppendingPathComponent:ProfileName]];
    return model_;
}

+ (LCUserProfileModel *)getUserProfileModel {
    LCAccount *act = [LCAccount sharedInstance];
    LCUserProfileModel *model = act.userInfo;
    return model;
}

+ (void)updateUserProfileModel:(LCUserProfileModel *)newModel {
    LCAccount *act = [LCAccount sharedInstance];
    LCUserProfileModel *model = act.userInfo;
    if ([model isEqual:newModel]) {
        return;
    } else {
        model = newModel;
    }
    act.userInfo = model;
}

- (void)cacheUserProfile:(LCUserProfileModel *)items
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [self getFilePath];
    NSString *path_profile = [path stringByAppendingPathComponent:ProfileName];
    if (![manager fileExistsAtPath:path])
    {
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    BOOL result_profile = [NSKeyedArchiver archiveRootObject:items toFile:path_profile];
    if (result_profile)
    {
        NSLog(@"保存个人资料成功");
    }
}

- (NSString *)getFilePath {
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documents stringByAppendingPathComponent:self.c_id];
    return path;
}

- (void)setObject:(id)object forKey:(NSString *)key {
    GET_USER_DEFAULTS(defaults);
    [defaults setObject:object forKey:key];
    [defaults synchronize];
}

- (id)getObjectWithKey:(NSString *)key {
    GET_USER_DEFAULTS(defaults);
    return [defaults objectForKey:key];
}

- (void)logOut {
    GET_USER_DEFAULTS(defaults);
    NSDictionary *dic = [defaults dictionaryRepresentation];
    for (NSString *object in dic.allKeys) {
        if (![object hasPrefix:@"lc_"]) {
            continue;
        }
        [defaults removeObjectForKey:object];
    }
    [defaults synchronize];    
}

@end
