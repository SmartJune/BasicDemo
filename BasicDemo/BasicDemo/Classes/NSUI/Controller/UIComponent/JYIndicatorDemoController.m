//
//  JYIndicatorDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/16.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYIndicatorDemoController.h"

@interface JYIndicatorDemoController ()

@end

@implementation JYIndicatorDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCommonIndicatorView];
}

- (void)setupCommonIndicatorView {

    //创建
    UIActivityIndicatorView *activityIndicatorView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    //位置
    activityIndicatorView.center=self.view.center;
    //样式
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //背景色
    [activityIndicatorView setBackgroundColor:[UIColor lightGrayColor]];
    //添加
    [self.view addSubview:activityIndicatorView];
    //开始动
    [activityIndicatorView startAnimating];
}

@end
