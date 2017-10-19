//
//  LCLoginModel.h
//  chubankuai
//
//  Created by old's mac on 2017/5/17.
//  Copyright © 2017年 gzlc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LCLoginModelData;

@interface LCLoginModel : NSObject

@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *ret;
@property (nonatomic, strong) LCLoginModelData *data;

@end


@interface LCLoginModelData : NSObject

@property (nonatomic, strong) NSString *c_id;
@property (nonatomic, strong) NSString *is_change;
@property (nonatomic, strong) NSString *session_id;

@end
