//
//  LinkCollectionViewCell.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/23.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "LinkCollectionViewCell.h"

@implementation LinkCollectionViewCell

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self=[[[NSBundle mainBundle]loadNibNamed:@"LinkCollectionViewCell" owner:self options:nil] lastObject];
    }
    return self;
}
@end
