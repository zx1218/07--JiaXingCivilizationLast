//
//  CommonViewController.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/22.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "CommonViewController.h"
#import "Common.h"
@interface CommonViewController ()<SDCycleScrollViewDelegate>
{
    float hight;
}
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property(nonatomic,strong)NSMutableArray *imageArray;
@property(nonatomic,strong)NSMutableArray *titleArray;


@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Common getCommon];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(play:)
     name:GetCommonDataNotification
     object:nil];
    
}
-(void) play: (NSNotification *)notification{
    //判断notification.object是否为数组
    if ([notification.object isKindOfClass:[NSArray class]]) {
        //将数据添加到相应的数组中
        for (Common *obj in notification.object) {
            [self.titleArray addObject:obj.title];
            [self.imageArray addObject:obj.imageurl];
        }
    }
    //实例化无限轮播
    SDCycleScrollView *cycle=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-110) imageURLStringsGroup:self.imageArray];
    cycle.titleLabelHeight=50;
    cycle.currentPageDotColor=[UIColor redColor];

    [cycle sizeToFit];
    [self.view addSubview:cycle];
    
    
}
#pragma set-数组的懒加载
-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray=[NSMutableArray array];
    }
    return _titleArray;
}

-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray=[NSMutableArray array];
    }
    return _imageArray;
}
#pragma mark-移除通知
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:HTTP_getCommon object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
