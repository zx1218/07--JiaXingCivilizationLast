//
//  Details.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/22.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "Details.h"

@implementation Details
+(void)getDetailsDataWithPageNum:(int)pageNum{
    return [[[self class]alloc]getDetailsDataWithPageNum:pageNum];
}

-(void)getDetailsDataWithPageNum:(int)pageNum{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSDictionary *dict=@{
                         @"categoryId":@1,
                         @"pageNum":@(pageNum)
                         };
    
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager POST:HTTP_getDetails parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"result"] isEqualToNumber:@0]) {
            //赋值数据给数组
            NSArray *tempData=responseObject[@"data"];
            [Details mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{@"titleNews":@"title"};
            }];
            
            NSArray *resultNews = [Details mj_objectArrayWithKeyValuesArray:tempData];
            [[NSNotificationCenter defaultCenter]postNotificationName:GetDetailsDataNotification object:resultNews];
            
        }else{
            NSLog(@"请求失败:%@",responseObject[@"message"]);
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络请求失败:%@",error);
        
    }];
    
}

@end
