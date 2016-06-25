//
//  Common.h
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/24.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject
@property(nonatomic,strong)AFHTTPSessionManager *manager;

@property(nonatomic,strong)NSString *imageurl;
@property(nonatomic,strong)NSNumber *commonwealId;
@property(nonatomic, strong)NSString * title;

+ (void)getCommon;
@end
