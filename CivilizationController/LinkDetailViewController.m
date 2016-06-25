//
//  LinkDetailViewController.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/23.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "LinkDetailViewController.h"
#import "LinkViewController.h"
@interface LinkDetailViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)NSArray *networkArr;
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation LinkDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSArray *arr=[user valueForKey:@"key"];
    self.title=arr[0];
    int a=[arr[1] intValue];
    _networkArr=@[@"http://jx.wenming.cn",@"http://www.zjwmw.com",@"http://www.cnjxol.com/index.htm",@"http://www.zjol.com.cn/",@"http://www.cncn.org.cn/",@"http://bot.jinhua.gov.cn/",@"http://www.hcyjw.cn/",@"http://nhnews.zjol.com.cn/nhnews/nhwm/",@"http://jxxznews.zjol.com.cn/xznews/xzwmw/",@"http://jx.zjol.com.cn/system/2015/06/30/020717765_01.shtml",@"http://wmw.tx.gov.cn/web/",@"http://zjhn.wenming.cn/",@"http://gfjy.jiaxing.gov.cn/",@"http://www.cnjxol.com/topic/qzlx/",@"http://www.nhyouth.gov.cn/"];
    
    self.webView.delegate=self;
    self.hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText=@"加载中...";
    [self.webView addSubview:self.hud];
    
    NSURL *url=[NSURL URLWithString:self.networkArr[a]];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];

}
-(void)webViewDidFinishLoad:(UIWebView *)webView{

    [self.hud hide:YES];
}
@end
