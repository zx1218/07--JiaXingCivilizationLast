//
//  NewsViewController.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/22.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
#import "OtherNewsTableViewCell.h"
#import "DetailsViewController.h"
#import "News.h"
#import "Banner.h"
#import "Details.h"


@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *newsTableView;
@property(nonatomic,strong)NSMutableArray<News *> *newsArr;
@property(nonatomic,strong)NSArray *headerImageArr;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)UIScrollView *headerScrollView;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)SDCycleScrollView *cycle;
@property(nonatomic,assign)int categoryId;
@property(nonatomic,assign)int pageNum;

@end

@implementation NewsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _categoryId=1;
    _pageNum=1;

    [Banner getBannerDataWithNumOfCategoryId:_categoryId];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleNotificationByBanner:) name:GetBannerDataNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleNotificationByNews:) name:GetNewsDataNotification object:nil];
    //下拉刷新
    self.newsTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [News getNewDatacategoryId:_categoryId withpageNum:_pageNum];
    }];
    
    [self.newsTableView.mj_header beginRefreshing];
    //上拉刷新
    self.newsTableView.mj_footer=[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [News getNewDatacategoryId:_categoryId withpageNum:++_pageNum];
    }];
    //注册
    [self.newsTableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:@"reuse"];
    [self.newsTableView registerClass:[OtherNewsTableViewCell class] forCellReuseIdentifier:@"otherReuse"];

}
#pragma mark 处理获取新闻数据时的通知
-(void)handleNotificationByNews:(NSNotification *)notification{
    if (_pageNum==1) {
        self.newsArr=[NSMutableArray array];
    }
    if ([notification.object isKindOfClass:[NSArray class]]) {
        [self.newsArr addObjectsFromArray:notification.object];
        [self.newsTableView reloadData ];
    }
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
    if (_categoryId==7) {
        
        OtherNewsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"otherReuse"];
        
        News *news = self.newsArr[indexPath.row];
        [cell.otherImageView setImageWithURL:[NSURL URLWithString:news.image] placeholderImage:[UIImage imageNamed:@"backgroundImage"]];
        cell.otherTitle.text=news.summary;
        NSString *time = news.issuestime ;
        NSRange range = {5,time.length-5};
        NSString * string =[time substringWithRange:range];
        NSRange rangeOne = {0,11};
        cell.otherTime.text = [string substringWithRange:rangeOne];
        return cell;
        
    }
    else{
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
}
//设置cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_categoryId==7) {
        return 150;
    }else{
        return 106;
    }
}
//顶部轮播图
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
//选中某行跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    News *news=self.newsArr[indexPath.row];
    int tempNum=(int)indexPath.row;
   
    NSDictionary *dict=@{
                        @"newsId":news.newsId,
                        @"categoryFk":@(_categoryId),
                        @"pageNum":@(tempNum)
                        };
    
    [self performSegueWithIdentifier:@"jump" sender:dict];
}
#pragma mark 线传值
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"jump"]) {
        UIViewController *viewCon=[segue destinationViewController];
        [viewCon setValue:sender forKey:@"dictionary"];
    }
}
-(void)setcategoryId:(int)categoryId{
    _categoryId=categoryId;
    [self.newsTableView.mj_header beginRefreshing];
}
@end
