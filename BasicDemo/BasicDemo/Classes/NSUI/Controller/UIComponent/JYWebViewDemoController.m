//
//  JYWebViewDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/17.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYWebViewDemoController.h"

@interface JYWebViewDemoController ()

@end

@implementation JYWebViewDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCommonWebView];
}

- (void)setupCommonWebView {

    //JS调用OC的方式，太长了，用到再说
    //http://www.cnblogs.com/ios8/p/ios-js-oc.html
    
    //创建
    UIWebView* webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //自动对页面进行缩放以适应屏幕
    webView.scalesPageToFit = YES;
    //自动检测网页上的电话号码，单击可以拨打
    webView.detectsPhoneNumbers = YES;
    //创建URL
    NSURL* url = [NSURL URLWithString:@"http://www.baidu.com"];
    //创建NSURLRequest
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    //加载
    [webView loadRequest:request];
    //代理
    webView.delegate = self;
    //背景
    webView.backgroundColor=[UIColor clearColor];
    webView.opaque=NO;//这句话很重要
    //添加视图
    [self.view addSubview:webView];
}

//当网页视图被指示载入内容而得到通知。应当返回YES，这样会进行加载。通过导航类型参数可以得到请求发起的原因
-(BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*) reuqest navigationType: (UIWebViewNavigationType)navigationType {
    
    return YES;
}

//当网页视图已经开始加载一个请求后，得到通知。
- (void)webViewDidStartLoad:(UIWebView*)webView {

}

//当网页视图结束加载一个请求之后，得到通知。
- (void)webViewDidFinishLoad:(UIWebView*)webView {
    //调JS
    NSString *jsCode = [NSString stringWithFormat:@"alert(1);"];
    [webView stringByEvaluatingJavaScriptFromString:jsCode];
}

//当在请求加载中发生错误时，得到通知。会提供一个NSSError对象，以标识所发生错误类型。
- (void)webView:(UIWebView*)webView DidFailLoadWithError:(NSError*)error {

}

@end
