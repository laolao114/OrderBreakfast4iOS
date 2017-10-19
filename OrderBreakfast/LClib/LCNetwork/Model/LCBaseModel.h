//
//  LCBaseModel.h
//
//  Created by 姚云恒 on 2016/10/14.
//  Copyright © 2016年 GZLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LCBaseModelData;
@interface LCBaseModel : NSObject

@property (nonatomic, assign) NSInteger ret;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) LCBaseModelData *baseModelData;

@end

@interface LCBaseModelData : NSObject

@property (nonatomic, copy) NSString *error;

@property (nonatomic, copy) NSString *msg;

@end
