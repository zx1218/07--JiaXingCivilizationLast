//
//  NewsTableViewCell.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/22.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self=[[[NSBundle mainBundle]loadNibNamed:@"NewsTableViewCell" owner:self options:nil]lastObject];
    }
    //圆角
    self.image.layer.cornerRadius=5;
    //裁剪
    self.image.clipsToBounds=YES;
    return self;
}

@end
