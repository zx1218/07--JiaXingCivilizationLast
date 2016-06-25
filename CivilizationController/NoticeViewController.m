//
//  NoticeViewController.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/23.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeTableViewCell.h"
#import "Notice.h"
@interface NoticeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)NSArray *timeArray;

@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableview.backgroundColor=[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    [_tableview registerClass:[NoticeTableViewCell class] forCellReuseIdentifier:@"cell"];
    [Notice getDataAnnouncement];
    _timeArray=[NSMutableArray arrayWithArray:@[@"2014-07-10 06:53:00",@"2013-11-22 11:11:41",@"2013-07-01 09:41:48"]];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(print:) name:@"获取通告"object:nil];
}
-(void)print:(NSNotification *)notification{
    if ([notification.object isKindOfClass:[NSArray class]]) {
        _array=notification.object;
        //所有数据加载完后，再去刷新
        [self.tableview reloadData ];
    }
    
}
#pragma mark 设置显示行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array.count;
}
#pragma mark 绘制cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoticeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    Notice *tonGao=self.array[indexPath.row];
    cell.title.text=tonGao.title;
    cell.conTitle.text=tonGao.content;
    cell.time.text=_timeArray[indexPath.row];
//    cell.backgroundColor=[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"获取通告" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}
@end
