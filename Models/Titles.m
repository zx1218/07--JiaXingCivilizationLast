//
//  Titles.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/22.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "Titles.h"

@implementation Titles
+(void)getTitlesData{
    return [[[self class]alloc]getTitlesData];
}

-(void)getTitlesData{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSDictionary *dict=@{
                         @"categoryId":@1,
                         };
    
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager POST:HTTP_getTitles parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"网络请求成功");
        if ([responseObject[@"result"] isEqualToNumber:@0]) {
            //赋值数据给数组
            NSArray *titlesData=responseObject[@"data"];
            NSArray *resultTitles = [Titles mj_objectArrayWithKeyValuesArray:titlesData];
            [[NSNotificationCenter defaultCenter]postNotificationName:GetBannerDataNotification object:resultTitles];
            
        }else{
            NSLog(@"请求失败:%@",responseObject[@"message"]);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络请求失败:%@",error);
    }];
    
}

@end
