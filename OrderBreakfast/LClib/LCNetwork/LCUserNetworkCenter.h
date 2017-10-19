//
//  LCUserNetworkCenter.h
//
//  Created by yaoyunheng on 2016/10/25.
//  Copyright © 2016年 GZLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCNetworkCenter.h"

@interface LCUserNetworkCenter : NSObject

+ (void)getUserProfileSuccess:(LCNetworkSuccessBlock)successBlock failure:(LCNetworkFailureBlock)failureBlock;

+ (BOOL)checkLoginWithLoginedBlock:(void(^)(void))loginedBlock;

+ (BOOL)checkLoginWithLoginedBlock:(void (^)(void))loginedBlock andLoginInsuccessBlock:(void(^)(void))loginInsuccessBlock;

+ (void)showLogin;

@end
