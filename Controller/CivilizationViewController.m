//
//  CivilizationViewController.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/22.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "CivilizationViewController.h"
#import "TwoViewController.h"
#import "NoticeViewController.h"
#import "LinkViewController.h"
#import "ShareViewController.h"
@interface CivilizationViewController ()
@property(nonatomic,strong)NSArray *titlesArr;
@property(nonatomic,strong)NSArray *titles;
@end

@implementation CivilizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlesArr=@[@"二维码",@"通知公告",@"友情链接",@"分享好友"];

    TwoViewController *twoView=[self.storyboard instantiateViewControllerWithIdentifier:@"twoViewController"];
    twoView.title=self.titlesArr[0];
    NoticeViewController *notice=[self.storyboard instantiateViewControllerWithIdentifier:@"noticeViewController"];
    notice.title=self.titlesArr[1];
    LinkViewController *link=[self.storyboard instantiateViewControllerWithIdentifier:@"linkViewController"];
    link.title=self.titlesArr[2];
    ShareViewController *share=[self.storyboard instantiateViewControllerWithIdentifier:@"shareViewController"];
    share.title=self.titlesArr[3];

    
    YSLContainerViewController *containerTitles=[[YSLContainerViewController alloc]initWithControllers:@[twoView,notice,link,share] topBarHeight:64 parentViewController:self];
    
    containerTitles.menuItemTitleColor=[UIColor blackColor];
    containerTitles.menuItemSelectedTitleColor=[UIColor redColor];
    containerTitles.menuIndicatorColor=[UIColor redColor];
    [self.view addSubview:containerTitles.view];
}

@end
