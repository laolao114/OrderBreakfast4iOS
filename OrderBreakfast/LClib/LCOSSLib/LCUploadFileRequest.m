//
//  LCUploadFileRequest.m
//  ShiJiaoSuo
//
//  Created by J on 16/5/10.
//  Copyright © 2016年 Guangzhou Shijiaosuo. All rights reserved.
//

#import "LCUploadFileRequest.h"

@implementation LCUploadFileRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        self.baseUrl = [LCNetworkHelper sharedInstance].baseUrl;
        self.requestType = LCBaseRequestTypePOST;
    }
    return self;
}

- (NSString *)uploadUrl {
    NSString *baseUrlTemp;
    
    //如果没有设置请求服务器的地址就用 LCNetworkHelper 的默认设置
    if (_uploadUrl.length == 0) {
        baseUrlTemp = [LCNetworkHelper sharedInstance].baseUrl;
        
        NSString *paramStr;
        
        if (_imageFile) {
            NSString *urlTemp = @"/v1/image/upload?obj=user&type1=";
            
            if (_fileType == LCUploadFileTypeAvatar) {
                paramStr = [NSString stringWithFormat:@"%@%@", urlTemp, @"avatar"];
            } else if (_fileType == LCUploadFileTypeNormalImage) {
                paramStr = [NSString stringWithFormat:@"%@", urlTemp];
            }
        }
        else if (_videoUrl) {
            
        }
        
        _uploadUrl = [NSString stringWithFormat:@"%@%@", baseUrlTemp, paramStr];
        
    }
    
    return _uploadUrl;
}

@end
