//
//  Notice.h
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/24.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notice : NSObject
@property(nonatomic,strong)NSString *announcementId;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *imageurl;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)AFHTTPSessionManager *manager;
+(void)getDataAnnouncement;
-(void)getAnnouncement;
@end
