//
//  News.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/22.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "News.h"

@implementation News
+(void)getNewsDataWithPageNum:(int)pageNum{
    return [[[self class]alloc]getNewsDataWithPageNum:pageNum];
}

-(void)getNewsDataWithPageNum:(int)pageNum{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSDictionary *dict=@{
                         @"categoryId":@1,
                         @"pageNum":@(pageNum)
                         };
    
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager POST:HTTP_getBanner parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        if ([responseObject[@"result"] isEqualToNumber:@0]) {
            //赋值数据给数组
            NSArray *tempData=responseObject[@"data"];
            NSArray *resultNews = [News mj_objectArrayWithKeyValuesArray:tempData];
            [[NSNotificationCenter defaultCenter]postNotificationName:GetNewsDataNotification object:resultNews];
            
        }else{
            NSLog(@"请求失败:%@",responseObject[@"message"]);
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络请求失败:%@",error);
        
    }];
    
}
@end
