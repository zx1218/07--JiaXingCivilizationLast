//
//  TitlesViewController.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/22.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "TitlesViewController.h"
#import "NewsViewController.h"

@interface TitlesViewController ()<YSLContainerViewControllerDelegate>
@property(nonatomic,strong)NSArray *titlesArr;
@property(nonatomic,strong)NSArray *titles;

@end

@implementation TitlesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *mutableArr=[NSMutableArray array];
    self.titlesArr=@[@"文明播报",@"道德模范",@"文明创建",@"志愿服务",@"未成年人",@"区县传真",@"主题活动",@"我们的节日"];
    for (int i=0; i<self.titlesArr.count; i++) {
        NewsViewController *content=[self.storyboard instantiateViewControllerWithIdentifier:@"NewsView"];
        content.title=self.titlesArr[i];
        [mutableArr addObject:content];
    }
    
    YSLContainerViewController *containerTitles=[[YSLContainerViewController alloc]initWithControllers:mutableArr topBarHeight:64 parentViewController:self];
    containerTitles.delegate=self;
    containerTitles.menuItemTitleColor=[UIColor blackColor];
    containerTitles.menuItemSelectedTitleColor=[UIColor redColor];
    containerTitles.menuIndicatorColor=[UIColor redColor];
    [self.view addSubview:containerTitles.view];
}
- (void)containerViewItemIndex:(NSInteger)index currentController:(NewsViewController *)controller;
{
 
    [controller viewWillAppear:YES];
    [controller setcategoryId:(int)index+1];
    
}
@end
