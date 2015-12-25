//
//  JYMBProgressHUDController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/21.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYMBProgressHUDController.h"
#import "MBProgressHUD+MJ.h"

@interface JYMBProgressHUDController ()

@end

@implementation JYMBProgressHUDController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 展示登陆的网页 -> UIWebView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
//     NSString *urlStr = @"http://pws.paic.com.cn/m/";
    NSString *urlStr = @"https://www.baidu.com";
    // 创建URL
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 加载请求
    [webView loadRequest:request];
    
    // 设置代理
    webView.delegate = self;
    
}

//开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // 提示用户正在加载...
    [MBProgressHUD showMessage:@"正在加载..."];
}

// webview加载完成的时候调用
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

//  webview加载失败的时候调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

@end
