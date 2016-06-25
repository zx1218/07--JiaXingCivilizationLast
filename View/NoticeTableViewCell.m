//
//  NoticeTableViewCell.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/24.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "NoticeTableViewCell.h"

@implementation NoticeTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self=[[[NSBundle mainBundle]loadNibNamed:@"NoticeTableViewCell" owner:self options:nil] lastObject];
        //设置边框
//        _title.layer.borderColor = [UIColor grayColor].CGColor;
//        _title.layer.borderWidth = 0.5;
//        _title.layer.cornerRadius=2;
//        //超出部分不显示
//        _title.clipsToBounds=YES;
    }
    return self;
}

@end
