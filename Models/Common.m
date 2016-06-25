//
//  Common.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/24.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "Common.h"

@implementation Common
+ (void)getCommon
{
    [[[self class] alloc]getCommon];
}

#pragma mark 获取TableView的数据
-(void)getCommon
{
    NSDictionary *dict=@{@"categoryId":@1};
    [self.manager POST:HTTP_getCommon parameters:dict progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   if ([responseObject[@"result"] isEqualToNumber:@0]) {
                       //通过一个中间变量获取Json数据
                       NSArray *temp=responseObject[@"data"];
                       //将其转换为模型
                       NSArray *resultNews= [Common mj_objectArrayWithKeyValuesArray:temp];
                       //发送通知数据请求完成
                       [[NSNotificationCenter defaultCenter]postNotificationName:GetCommonDataNotification  object:resultNews];
                   }
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   NSLog(@"%@",error);
               }];
}
- (AFHTTPSessionManager *)manager
{
    if (_manager) {
        return  _manager;
    }
    _manager = [AFHTTPSessionManager manager];
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    return _manager;
}
@end

