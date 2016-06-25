//
//  Notice.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/24.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "Notice.h"

@implementation Notice

- (AFHTTPSessionManager *)manager
{
    if (_manager) {
        return  _manager;
    }
    _manager = [AFHTTPSessionManager manager];
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    return _manager;
}
+(void)getDataAnnouncement{
    [[[self class] alloc] getAnnouncement];
}
-(void)getAnnouncement{
    [self.manager POST:HTTP_getAnnouncement parameters:@{@"pageNum":@1} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"result"]isEqualToNumber:@0]) {
            NSMutableArray * array=[Notice mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"获取通告" object:array];
        }else{
            NSLog(@"请求失败%@",responseObject[@"message"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"出错了%@",error.localizedDescription);
    }];
}

@end
