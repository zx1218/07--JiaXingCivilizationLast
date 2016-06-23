//
//  DetailsViewController.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/22.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "DetailsViewController.h"
#import "Details.h"
@interface DetailsViewController ()<UIWebViewDelegate>
{
    MBProgressHUD *hud;
    UIView *vLoging;
}
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@end

@implementation DetailsViewController

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //拦截网页中的图片  并修改图片大小
    [self.detailWebView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth=450;" //缩放系数
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = 300;"
     "myimg.height = 200;"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    
    //执行一段JavaScript代码
    [self.detailWebView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    //获取HTML内容的高度
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    CGRect frame = webView.frame;
    frame.size.height = height+10;
    
    self.detailWebView.frame = frame;
    
    //修改托线约束，因为高度不固定，故托线后进行修改
    self.webHeight.constant = frame.origin.y+height+10;
    //设置滚动视图的ContentSize
    self.detailScroll.contentSize = CGSizeMake(320, frame.origin.y+height+10);
    
    
    [self.view layoutIfNeeded];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    vLoging = [[UIView alloc]initWithFrame:SCREEN_BOUNDS];
    vLoging.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vLoging];
    
    
    self.detailWebView.delegate = self;
    self.detailWebView.userInteractionEnabled = NO;
    NSLog(@"%@",self.params);
    hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    //接口只支持POST
    [self.manager POST:HTTP_getDetails
            parameters:self.params
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   if ([responseObject[@"result"] isEqualToNumber:@0]) {
                       NSDictionary *data = responseObject[@"data"];
                       
                       Details *news = [Details mj_objectWithKeyValues:data];
                       self.detailTitle.text = news.titleNews;
                       self.detailTime.text = [NSString stringWithFormat:@"发布日期:%@",news.issuestime];
                       self.detailSource.text=[NSString stringWithFormat:@"来源：%@",news.source];
                       self.detailTime.adjustsFontSizeToFitWidth = YES;
                    
                       [self.detailWebView loadHTMLString:news.content baseURL:nil];
                       
                       [vLoging removeFromSuperview];
                       [hud hide:NO];
                       
                   }else{
                       NSLog(@"请求错误：%@",responseObject[@"message"]);
                   }
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   NSLog(@"出错了:%@",error);
               }];
    
}

- (AFHTTPSessionManager *)manager
{
    if (_manager) {
        return _manager;
    }
    _manager = [AFHTTPSessionManager manager];
    //请求的时候要使用JSON数据序列化
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    return _manager;
}




@end
