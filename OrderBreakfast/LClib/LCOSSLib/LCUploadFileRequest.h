//
//  LCUploadFileRequest.h
//  ShiJiaoSuo
//
//  上传文件请求类
//
//  Created by J on 16/5/10.
//  Copyright © 2016年 Guangzhou Shijiaosuo. All rights reserved.
//

#import "LCBaseRequest.h"

//上传的文件类型
typedef NS_ENUM (NSInteger, LCUploadFileType) {
    LCUploadFileTypeAvatar = 1,     //头像
    LCUploadFileTypeNormalImage     
};

@interface LCUploadFileRequest : LCBaseRequest

//上传请求地址
@property (copy, nonatomic) NSString *uploadUrl;
//数据模型类名
//@property (copy, nonatomic) NSString *modelName;
//文件所属目标的 id
@property (nonatomic) NSInteger fileTargetId;
//文件的索引
@property (nonatomic) NSInteger fileIndex;
//文件类型
@property (nonatomic) LCUploadFileType fileType;
//文件后缀
@property (copy, nonatomic) NSString *fileSuffix;

//图片
@property (strong, nonatomic) UIImage *imageFile;
//视频
@property (strong, nonatomic) NSString *videoUrl;
//视频
@property (strong, nonatomic) NSData *video;
//参数名称
@property (nonatomic, strong) NSString *paramName;

@end
