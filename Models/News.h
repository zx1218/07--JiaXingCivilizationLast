//
//  News.h
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/22.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
@property(nonatomic,strong)NSString *newsTd;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *summary;
@property(nonatomic,strong)NSString *source;
@property(nonatomic,strong)NSString *isBanner;
@property(nonatomic,strong)NSNumber *praiseNum;
@property(nonatomic,strong)NSNumber *browseNum;
@property(nonatomic,strong)NSString *issuestime;
-(void)getNewsDataWithPageNum:(int)pageNum;
+(void)getNewsDataWithPageNum:(int)pageNum;
@end
