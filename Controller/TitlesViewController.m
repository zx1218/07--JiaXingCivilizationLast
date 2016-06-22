//
//  TitlesViewController.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/22.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "TitlesViewController.h"
#import "NewsViewController.h"
#import "Titles.h"
@interface TitlesViewController ()<YSLContainerViewControllerDelegate>
@property(nonatomic,strong)NSArray *titlesArr;
@property(nonatomic,strong)NSMutableArray *mutableArr;
@property(nonatomic,strong)NewsViewController *content;
@property(nonatomic,strong)NSArray *titles;

@end

@implementation TitlesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Titles getTitlesData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleNotificationByTitles:) name:GetTitlesDataNotification object:nil];
    
    _mutableArr=[NSMutableArray array];
    //Titles
    float navigationHeight=self.navigationController.navigationBar.frame.size.height;
    
    for (int i=0; i<self.titlesArr.count; i++) {
        self.content=[[NewsViewController alloc]init];
        self.content.title=self.titlesArr[i];
        [self.mutableArr addObject:self.content];
    }
    
    YSLContainerViewController *containerTitles=[[YSLContainerViewController alloc]initWithControllers:@[self.content] topBarHeight:navigationHeight parentViewController:self];
    containerTitles.delegate=self;
    containerTitles.menuItemTitleColor=[UIColor grayColor];
    containerTitles.menuItemSelectedTitleColor=[UIColor redColor];
    containerTitles.menuBackGroudColor=[UIColor whiteColor];
    [self.view addSubview:containerTitles.view];
}
- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller{
    NSLog(@"%ld",index);
    
    [controller viewWillAppear:YES];
}

#pragma mark 处理获取Banner数据时的通知
-(void)handleNotificationByTitles:(NSNotification *)object{
    
    if ([object.object isKindOfClass:[NSArray class]]) {
        self.titlesArr=object.object;
    }
    NSLog(@"%@",self.titlesArr);
}


@end
