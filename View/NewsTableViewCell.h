//
//  NewsTableViewCell.h
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/22.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *source;
@property (weak, nonatomic) IBOutlet UILabel *praiseNum;
@property (weak, nonatomic) IBOutlet UILabel *browseNum;
@end
