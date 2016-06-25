//
//  Details.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/22.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "Details.h"

@implementation Details
+(void)getDetailsDataWithDictionary:(NSDictionary *)dictionary{
     [[[self class]alloc]getDetailsDataWithDictionary:dictionary];
}

-(void)getDetailsDataWithDictionary:(NSDictionary *)dictionary{
    _set=[NSMutableSet setWithSet:self.manager.responseSerializer.acceptableContentTypes];
    [_set addObject:@"text/html"];
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    self.manager.responseSerializer.acceptableContentTypes=_set;

    [manager POST:HTTP_getDetails parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"result"] isEqualToNumber:@0]) {
            //赋值数据给数组
            NSArray *tempData=responseObject[@"data"];

            [[NSNotificationCenter defaultCenter]postNotificationName:GetDetailsDataNotification object:tempData];
            
        }else{
            NSLog(@"请求失败:%@",responseObject[@"message"]);
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络请求失败:%@",error);
        
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
