//
//  Titles.h
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/22.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Titles : NSObject
@property(nonatomic,strong)NSString *categoryName;
-(void)getTitlesData;
+(void)getTitlesData;
@end
