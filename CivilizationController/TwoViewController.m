//
//  TwoViewController.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/23.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.labelOne.text=@"扫一扫";
    self.labelTwo.text=@"关注嘉兴文明网官方微信，更多精彩新闻，为您呈现";
    self.imageView.image=[UIImage imageNamed:@"二维码"];
    
}

@end
