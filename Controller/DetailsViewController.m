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

@property (nonatomic,strong) AFHTTPSessionManager *manager;
@property(nonatomic,strong)MBProgressHUD *hud;

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
    [self.hud hide:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailWebView.delegate = self;
    self.hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText=@"加载中...";
    [self.detailWebView addSubview:self.hud];

    [self registeredNSNotificationCenter];

}
#pragma mark 注册通知及调用数据网络请求方法
-(void)registeredNSNotificationCenter{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setParams:) name:GetDetailsDataNotification object:nil];
    [Details getDetailsDataWithDictionary:_dictionary];
}
#pragma mark 通知的回调方法
-(void)setParams:(NSNotification *)notification{
    self.detailTitle.text=[notification.object valueForKey:@"title"];
    [self.detailWebView loadHTMLString:[notification.object valueForKey:@"content"]baseURL:nil];
    self.detailTime.text=[notification.object valueForKey:@"issuestime"];
    self.detailSource.text=[notification.object valueForKey:@"source"];
}

@end
