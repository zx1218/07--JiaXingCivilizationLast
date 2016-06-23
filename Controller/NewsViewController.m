//
//  NewsViewController.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/22.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
#import "DetailsViewController.h"
#import "News.h"
#import "Banner.h"
#import "Details.h"


@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *newsTableView;

@property(nonatomic,strong)NSMutableArray *newsArr;
@property(nonatomic,strong)NSArray *headerImageArr;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)UIScrollView *headerScrollView;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)SDCycleScrollView *cycle;
@property(nonatomic,strong)NSMutableArray<Details *> *detailArr;
@end

@implementation NewsViewController
//int categoryId=1;
int pageNum;
- (void)viewDidLoad {
    [super viewDidLoad];
    

    [Banner getBannerData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleNotificationByBanner:) name:GetBannerDataNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleNotificationByNews:) name:GetNewsDataNotification object:nil];
    
    
    self.newsTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        pageNum=1;
        [News getNewsDataWithPageNum:pageNum];
    }];
    
    [self.newsTableView.mj_header beginRefreshing];
    self.newsTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [News getNewsDataWithPageNum:++pageNum];
    }];
    
    [self.newsTableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:@"reuse"];
    
}
#pragma mark 处理获取新闻数据时的通知
-(void)handleNotificationByNews:(NSNotification *)object{
    if (pageNum==1) {
        self.newsArr=[NSMutableArray array];
    }
    if ([object.object isKindOfClass:[NSArray class]]) {
        [self.newsArr addObjectsFromArray:object.object];
    }
    
    [self.newsTableView reloadData];
    [self.newsTableView.mj_header endRefreshing];
    [self.newsTableView.mj_footer endRefreshing];
}
#pragma mark 处理获取Banner数据时的通知
-(void)handleNotificationByBanner:(NSNotification *)object{
    
    if ([object.object isKindOfClass:[NSArray class]]) {
        self.headerImageArr=object.object;
    }
    [self cycleScrollView];
    self.newsTableView.tableHeaderView=self.cycle;
}
//tableView行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsArr.count;
}
//绘制cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    //取数据
    News *news=self.newsArr[indexPath.row];
    [cell.image setImageWithURL:[NSURL URLWithString:news.image] placeholderImage:[UIImage imageNamed:@"backgroundImage"]];
    cell.title.text=news.title;
    cell.praiseNum.text=[NSString stringWithFormat:@"%@",news.praiseNum];
    cell.browseNum.text=[NSString stringWithFormat:@"%@",news.browseNum];
    cell.source.text=news.source;
    
    return cell;
}
//设置cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 106;
}

-(SDCycleScrollView *)cycleScrollView{
    if (_cycle==nil) {
        _cycle=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,SCREEN_WIDTH,200) delegate:self placeholderImage:[UIImage imageNamed:@"backgroundImage"]];
        
        //图片
        _cycle.imageURLStringsGroup=[_headerImageArr valueForKey:@"imageurl"];
        //    _cycle.pageControlStyle=SDCycleScrollViewPageContolStyleAnimated;
        _cycle.pageControlAliment=SDCycleScrollViewPageContolAlimentRight;
        _cycle.currentPageDotColor=[UIColor orangeColor];
        
        //文字
        _cycle.titlesGroup=[_headerImageArr valueForKey:@"title"];
        
    }
    
    return _cycle;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Details *detail=self.detailArr[indexPath.row];
    DetailsViewController *detailView=[self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    int tempNum=(pageNum-1)*10+(int)indexPath.row;
    [detailView setParams:@{
                            @"newsId":detail.newsId,
                            @"categoryFk":@1,
                            @"pageNum":@(tempNum)
                            }];
    
    [self.navigationController pushViewController:detailView animated:YES];
}
@end
