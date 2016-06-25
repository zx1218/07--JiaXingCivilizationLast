//
//  Banner.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/22.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "Banner.h"

@implementation Banner
+(void)getBannerDataWithNumOfCategoryId:(int)num{
    return [[[self class]alloc]getBannerDataWithNumOfCategoryId:(int)num];
}

-(void)getBannerDataWithNumOfCategoryId:(int)num{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSDictionary *dict=@{
                         @"categoryId":@(num)
                         };
    
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager POST:HTTP_getHeaderData parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"网络请求成功");
        if ([responseObject[@"result"] isEqualToNumber:@0]) {
            //赋值数据给数组
            NSArray *bannerData=responseObject[@"data"];
            NSArray *resultNews = [Banner mj_objectArrayWithKeyValuesArray:bannerData];
            [[NSNotificationCenter defaultCenter]postNotificationName:GetBannerDataNotification object:resultNews];
            
        }else{
            NSLog(@"请求失败:%@",responseObject[@"message"]);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络请求失败:%@",error);
    }];
    
}

@end
