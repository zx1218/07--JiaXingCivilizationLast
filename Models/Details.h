//
//  Details.h
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/22.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Details : NSObject
@property (nonatomic,strong) AFHTTPSessionManager * manager;
@property (nonatomic,strong) NSNumber * newsId;
@property (nonatomic,strong) NSString * titleNews;
@property (nonatomic,strong) NSString * summary;
@property (nonatomic,strong) NSString * source;
@property (nonatomic,strong) NSString * image;
@property (nonatomic,strong) NSString * browseNum;
@property (nonatomic,strong) NSString * issuestime;

@property (nonatomic,strong) NSString * categoryFk;
@property (nonatomic,strong) NSString * content;
@property (nonatomic,strong) NSString * link;

@property(nonatomic,strong)NSMutableSet *set;

-(void)getDetailsDataWithDictionary:(NSDictionary *)dictionary;
+(void)getDetailsDataWithDictionary:(NSDictionary *)dictionary;
@end
