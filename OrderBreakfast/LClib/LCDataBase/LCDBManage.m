//
//  LCDBManage.m
//
//  Created by yaoyunheng on 2016/11/9.
//  Copyright © 2016年 GZLC. All rights reserved.
//

#import "LCDBManage.h"
#import "FMDB.h"

#define DataBaseFilePath        @"/LCDBManage"
#define PATH_OF_DOCUMENT [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@interface LCDBManage () {
    
}

@property (nonatomic, retain) NSString * dbPath;
@property (nonatomic, assign) BOOL isUpdating;

@end

@implementation LCDBManage

+ (LCDBManage *)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if(self) {
        // 犹豫限制，不能直接修改项目db文件，需要将db拷贝一份到沙盒。
        NSString *doc = PATH_OF_DOCUMENT;
        NSString *path = [doc stringByAppendingPathComponent:@"/database/user.sqlite"];
        self.dbPath = path;
        BOOL isDir = NO;
        BOOL existed = [[NSFileManager defaultManager] fileExistsAtPath:self.dbPath isDirectory:&isDir];
        if (!(isDir == YES && existed == YES)) {
            // 如果沙盒不存在db文件，则创建一份。
            [self createDB];
        }
//        FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
    }
    return self;
}

- (FMDatabase *)createDB {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    NSError *error;
    BOOL existed = [fileManager fileExistsAtPath:self.dbPath isDirectory:&isDir];
    if (!(isDir == YES && existed == YES) ) {
        NSString *path = [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"/database"];
        BOOL bo = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if (bo) {
            NSString *resourcePath =[[NSBundle mainBundle] pathForResource:@"lc" ofType:@"db"];
            if([fileManager copyItemAtPath:resourcePath toPath:self.dbPath error:&error]) {
                FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
                if ([db open]) {
                }
                [db close];
                return db;
            }
        } else {
            return nil;
        }
    }
    return nil;
}

// 清除db数据
- (void)clearAllData {
    FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString *sql = @"DELETE FROM user";
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            NSLog(@"error to delete db data");
        } else {
            NSLog(@"succ to deleta db data");
        }
        [db close];
    }
}

#pragma mark - 地区

- (NSMutableArray<LCAddressListDataModel *> *)getAllCountryData {
    NSMutableArray *array   = [[NSMutableArray alloc]init];
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString *sql = @"SELECT * FROM ft_region WHERE parent_id = 0 ORDER BY sort, region_id";
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString *regionID = [rs stringForColumn:@"region_id"];
            NSString *name = [rs stringForColumn:@"region_name"];
            NSString *flag = [rs stringForColumn:@"end_flag"];
            NSString *regionLevel = [rs stringForColumn:@"region_level"];
            LCAddressListDataModel *model = [LCAddressListDataModel new];
            model.region_id = regionID;
            model.region_name = name;
            model.region_level = regionLevel;
            model.end_flag = flag;
        }
        [db close];
    }
    return array;
}

/*
 *  获取中国下的全部省份
 */
- (NSMutableArray<LCAddressListDataModel *> *)getAllProvinceInChina {
    return [self getProvinceDataFrom:@"1"];
}

- (NSMutableArray<LCAddressListDataModel *> *)getProvinceDataFrom:(NSString *)countryID {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM ft_region WHERE parent_id = %@ ORDER BY sort", countryID];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString *regionID = [rs stringForColumn:@"region_id"];
            NSString *name = [rs stringForColumn:@"region_name"];
            NSString *flag = [rs stringForColumn:@"end_flag"];
            NSString *regionLevel = [rs stringForColumn:@"region_level"];
            LCAddressListDataModel *model = [LCAddressListDataModel new];
            model.region_id = regionID;
            model.region_name = name;
            model.region_level = regionLevel;
            model.end_flag = flag;
            [array addObject:model];
        }
        [db close];
    }
    return array;
}

- (NSMutableArray<LCAddressListDataModel *> *)getCityDataFrom:(NSString *)provinceID {
    NSMutableArray<LCAddressListDataModel *> *array = [[NSMutableArray alloc] init];
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM ft_region WHERE parent_id = %@ ORDER BY sort", provinceID];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString *regionID = [rs stringForColumn:@"region_id"];
            NSString *name = [rs stringForColumn:@"region_name"];
            NSString *flag = [rs stringForColumn:@"end_flag"];
            NSString *regionLevel = [rs stringForColumn:@"region_level"];
            LCAddressListDataModel *model = [LCAddressListDataModel new];
            model.region_id = regionID;
            model.region_name = name;
            model.region_level = regionLevel;
            model.end_flag = flag;
            [array addObject:model];
        }
        [db close];
    }
    return array;
}

- (NSMutableArray<LCAddressListDataModel *> *)getDistrictDataFrom:(NSString *)cityID {
    NSMutableArray<LCAddressListDataModel *> *array = [[NSMutableArray alloc]init];
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM ft_region WHERE parent_id = %@ ORDER BY sort", cityID];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString *regionID = [rs stringForColumn:@"region_id"];
            NSString *name = [rs stringForColumn:@"region_name"];
            NSString *flag = [rs stringForColumn:@"end_flag"];
            NSString *regionLevel = [rs stringForColumn:@"region_level"];
            LCAddressListDataModel *model = [LCAddressListDataModel new];
            model.region_id = regionID;
            model.region_name = name;
            model.region_level = regionLevel;
            model.end_flag = flag;
            [array addObject:model];
        }
        [db close];
    }
    return array;
    
}

#pragma mark - 手机号码前缀

- (NSDictionary *)getMobilePrefix {
    NSMutableDictionary *dic    = [[NSMutableDictionary alloc]init];
    NSMutableArray *nameArray = [[NSMutableArray alloc] init];
    NSMutableArray *numArray = [[NSMutableArray alloc] init];
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString *sql = @"SELECT * FROM ft_country_mobile_prefix";
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString *name = [rs stringForColumn:@"country"];
            [nameArray addObject:name];
            NSString *num = [rs stringForColumn:@"mobile_prefix"];
            [numArray addObject:num];
        }
        [dic setObject:nameArray forKey:COUNTRY_NAME_KEY];
        [dic setObject:numArray forKey:MOBILE_PREFIX_KEY];
        [db close];
    }
    return dic;
}

#pragma mark - 系统配置

- (NSString *)getPlayMethod {
    NSString *playMethod;
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM ft_sys_content"];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            LCSysContnetModel *model = [LCSysContnetModel new];
            model.item = [rs stringForColumn:@"item"];
            model.content = [rs stringForColumn:@"content"];
            if ([model.item isEqualToString:@"play_method"]) {
                playMethod = model.content;
            }
        }
        [db close];
    }
    return playMethod;
}

- (NSString *)getAgreement {
    NSString *agreement;
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM ft_sys_content"];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            LCSysContnetModel *model = [LCSysContnetModel new];
            model.item = [rs stringForColumn:@"item"];
            model.content = [rs stringForColumn:@"content"];
            if ([model.item isEqualToString:@"agreement"]) {
                agreement = model.content;
            }
        }
        [db close];
    }
    return agreement;
}

#pragma mark - something updateDB
- (void)updateDB {
    NSString *maxTime = [self getMaxTimeInterval];
    [LCNetworkCenter getWithPath:@"common.cache" parameters:@{@"update_time": maxTime} success:^(id responseObject) {
        LCDBUpdateModel *model = [LCDBUpdateModel modelWithJSON:responseObject];
//            [LCHUD showProcessing:@"正在努力更新数据库，请稍等" target:nil];
            // 异步执行数据库更新 防止当前线程被阻塞
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [self handleUpdateData:model.data];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [LCHUD hide];
//            });
        });
    } failure:^(NSInteger errCode, NSString *errDescription) {
        [LCHUD showDelayError:errDescription target:nil];
    }];
}

- (NSString *)getMaxTimeInterval {
    NSString *temp_time = @"1";
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSArray *sqlArray = @[@"ft_region",
                              @"ft_sys_constant"];
        NSMutableArray *maxTimeArray = [[NSMutableArray alloc]initWithCapacity:0];
        for (int i = 0; i < sqlArray.count; i++) {
            NSString *sql = [NSString stringWithFormat:@"SELECT max(update_time) as update_time FROM %@", sqlArray[i]];
            FMResultSet *rs = [db executeQuery:sql];
            while ([rs next]) {
                [maxTimeArray addObject:[rs stringForColumn:@"update_time"] ? : @"1"];
            }
        }

        for (NSString *time in maxTimeArray) {
            if (temp_time.integerValue < time.integerValue) {
                temp_time = time;
            }
        }
    }
    [db close];
    return temp_time;
}

#pragma mark - handleUpdateData method
- (void)handleUpdateData:(LCDBUpdateData *)data {
    NSArray<NSArray *> *valueArray = [self getPropertyValueArrayWithData:data];
    NSArray<NSString *> *nameArray = [self getPropertyNameArrayWithClass:[LCDBUpdateData class]];
    int count = -1;
    for (NSArray<NSDictionary *> *array in valueArray) {
        count ++;
        if ([array isKindOfClass:[NSArray class]]) {
            if (array.count) {
                [array enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSMutableString *sqlString = [[NSMutableString alloc] initWithCapacity:0];
    //                NSString *keyIdString = [[nameArray[count] stringByReplacingOccurrencesOfString:@"fb_" withString:@""] stringByReplacingOccurrencesOfString:@"dict_" withString:@""];
    //                NSString *t_keyString = [keyIdString stringByAppendingString:@"_id"];
                    NSString *t_keyString = nameArray[count];
                    if ([obj[@"action"] isEqualToString:@"1"]) {
                        __block NSMutableString *insideKeyStr = [[NSMutableString alloc]initWithCapacity:0];
                        __block NSMutableString *insideValueStr = [[NSMutableString alloc]initWithCapacity:0];
                        [obj.allKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull inside_key, NSUInteger inside_key_idx, BOOL * _Nonnull stop) {
    //                        if ([inside_key isEqualToString:@"status"]) {
    //                            return ;
    //                        }
                            [insideKeyStr appendFormat:@"%@'%@'", @",", inside_key];
                            [insideValueStr appendFormat:@"%@'%@'", @",", obj.allValues[inside_key_idx]];
                        }];
                        insideKeyStr = [[NSMutableString alloc] initWithString:[insideKeyStr substringFromIndex:1]];
                        insideValueStr = [[NSMutableString alloc] initWithString:[insideValueStr substringFromIndex:1]];
                        
                        sqlString = (NSMutableString *)[NSString stringWithFormat:@"REPLACE INTO '%@' (%@) VALUES (%@)", t_keyString, insideKeyStr, insideValueStr];
                    } else if ([obj[@"action"] isEqualToString:@"2"]) {
                        [sqlString appendFormat:@"DELETE FROM '%@' WHERE '%@' IN ('%@')", nameArray[count],t_keyString, obj[t_keyString]];
                    }
                    [self updateInfoWithSql:sqlString];
                }];
            }
        }
    }
}

- (NSArray<NSString *> *)getPropertyNameArrayWithClass:(Class)class {
    NSMutableArray *nameArr = [[NSMutableArray alloc]initWithCapacity:0];
    unsigned int propertyCnt = 0;
    objc_property_t *property = class_copyPropertyList(class, &propertyCnt);
    for (int i = 0; i < propertyCnt; i ++) {
        objc_property_t property_in = property[i];
        const char *propertyName = property_getName(property_in);
        [nameArr addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(property);
    return nameArr;
}

- (SEL)getterWithPropertyName:(NSString *)name {
    return NSSelectorFromString(name);
}

- (NSArray *)getPropertyValueArrayWithData:(LCDBUpdateData *)data {
    NSMutableArray *valueArray = [[NSMutableArray alloc]initWithCapacity:0];
    NSArray<NSString *> *nameArray = [self getPropertyNameArrayWithClass:[data class]];
    [nameArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SEL getter = [self getterWithPropertyName:obj];
        if ([data respondsToSelector:getter]) {
            NSMethodSignature *signature = [data methodSignatureForSelector:getter];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            invocation.selector = getter;
            invocation.target = data;
            [invocation invoke];
            NSObject *__unsafe_unretained value = nil;
            [invocation getReturnValue:&value];
            [valueArray addObject:value ? : @""];
        }
    }];
    return valueArray;
}

- (void)updateInfoWithSql:(NSString *)sql {
    NSLog(@"======sql is %@", sql);
    if (sql.length == 0) {
        return;
    }
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        BOOL success = [db executeUpdate:sql];
        if (success) {
            NSLog(@"======更新成功^.^");
        }
    }
    [db close];
}

@end
