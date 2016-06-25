//
//  Banner.h
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/22.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Banner : NSObject
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *imageurl;
-(void)getBannerDataWithNumOfCategoryId:(int)num;
+(void)getBannerDataWithNumOfCategoryId:(int)num;
@end
