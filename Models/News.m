//
//  News.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/22.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "News.h"

@implementation News
+(void)getNewDatacategoryId:(int)categoryId withpageNum:(int)pageNum{
    [[[self class]alloc] getNewDatawithcategoryId:categoryId withpageNum:pageNum];
}
-(void)getNewDatawithcategoryId:(int)categoryId withpageNum:(int)pageNum{
    NSDictionary *dict=@{
                         @"categoryId":@(categoryId),
                         @"pageNum":@(pageNum)
                         };
    
    [self.manager POST:HTTP_getNews parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if ([responseObject[@"result"]isEqualToNumber:@0]) {

            NSArray *tempData=responseObject[@"data"];
            //把字典数组转化成对象数组
            self.newsArray=[NSMutableArray arrayWithArray:[News mj_objectArrayWithKeyValuesArray:tempData]];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:GetNewsDataNotification object:self.newsArray];
            
        }else{
            NSLog(@"请求失败%@",responseObject[@"message"]);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"出错了%@",error.localizedDescription);
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
-(NSMutableArray *)newsArray{
    if (!_newsArray) {
        _newsArray=[NSMutableArray array];
    }
    return _newsArray;
}

@end
