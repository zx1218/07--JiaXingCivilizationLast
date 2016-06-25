//
//  ProfoundViewController.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/22.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "ProfoundViewController.h"

@interface ProfoundViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation ProfoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.proWebView.delegate=self;
    self.hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText=@"加载中...";
    [self.proWebView addSubview:self.hud];
    
    NSURL *url=[NSURL URLWithString:@"http://weibo.com/u/2852517300?is_hot=1"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [_proWebView loadRequest:request];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self.hud hide:YES];
}
@end
