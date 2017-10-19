//
//  LCUserProfileModel.m
//
//  Created by yaoyunheng on 2016/10/25.
//  Copyright © 2016年 GZLC. All rights reserved.
//

#import "LCUserProfileModel.h"

@implementation LCUserProfileModel

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [self modelEncodeWithCoder:encoder];
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    return [self modelInitWithCoder:decoder];
}

@end

@implementation UserProfileData

- (void)encodeWithCoder:(NSCoder *)encoder {
    [self modelEncodeWithCoder:encoder];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    return [self modelInitWithCoder:decoder];
}

@end
