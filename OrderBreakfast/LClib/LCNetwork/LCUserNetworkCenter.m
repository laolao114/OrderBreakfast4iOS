//
//  LCUserNetworkCenter.m
//
//  Created by yaoyunheng on 2016/10/25.
//  Copyright © 2016年 GZLC. All rights reserved.
//

#import "LCUserNetworkCenter.h"

@implementation LCUserNetworkCenter

+ (void)getUserProfileSuccess:(LCNetworkSuccessBlock)successBlock failure:(LCNetworkFailureBlock)failureBlock {
    NSString *c_id = [LCAccount sharedInstance].c_id;
    [LCNetworkCenter getWithPath:@"common.customer_info" parameters:@{@"c_id" : c_id.length > 0 ? c_id : @""} success:^(id responseObject) {
        LCUserProfileModel *profileModel = [LCUserProfileModel modelWithJSON:responseObject];
        LCAccount *act = [LCAccount sharedInstance];
        act.userInfo = profileModel;
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSInteger errCode, NSString *errDescription) {
        if (failureBlock) {
            failureBlock(errCode, errDescription);
        }
    }];
}

#pragma mark - 判断是否已经登录，如果没有登录就显示登录注册向导页，登录的话就执行 block
+ (BOOL)checkLoginWithLoginedBlock:(void(^)(void))loginedBlock {
    LCAccount *account = [LCAccount sharedInstance];
    //如果没登录
    if (account.sessionId.length == 0) {
        [self showLogin];
        return NO;
    }
    //已登录，执行回调
    else {
        if (loginedBlock) {
            loginedBlock();
        }
        return YES;
    }
}

#pragma mark - 判断是否登录，如果是，执行loginedBlock,否则先调起loginController，然后登陆成功就执行loginInsuccessBlock
//+ (BOOL)checkLoginWithLoginedBlock:(void (^)(void))loginedBlock andLoginInsuccessBlock:(void(^)(void))loginInsuccessBlock {
//    LCAccount *account = [LCAccount sharedInstance];
//    //如果没登录
//    if (account.sessionId.length == 0) {
//        LoginViewController *login = [LoginViewController new];
//        login.loginSuccessBlock = ^{
//            if (loginInsuccessBlock) {
//                loginInsuccessBlock();
//            }
//        };
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
//        [[self visibleViewController] presentViewController:nav animated:YES completion:^{
//            
//        }];
//        return NO;
//    }
//    //已登录，执行回调
//    else {
//        if (loginedBlock) {
//            loginedBlock();
//        }
//        return YES;
//    }
//}
//
//+ (void)showLogin {
//    LoginViewController *login = [LoginViewController new];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
//    [[self visibleViewController] presentViewController:nav animated:YES completion:^{
//        
//    }];
//}

@end
