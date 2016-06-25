//
//  OtherNewsTableViewCell.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/23.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "OtherNewsTableViewCell.h"

@implementation OtherNewsTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self=[[[NSBundle mainBundle]loadNibNamed:@"OtherNewsTableViewCell" owner:self options:nil]lastObject];
    }
    //圆角
    self.otherImageView.layer.cornerRadius=5;
    //裁剪
    self.otherImageView.clipsToBounds=YES;
    return self;
}
@end
