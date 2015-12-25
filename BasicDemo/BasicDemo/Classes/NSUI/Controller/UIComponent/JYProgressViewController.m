//
//  JYProgressViewController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/16.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYProgressViewController.h"

@interface JYProgressViewController ()

@end

@implementation JYProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCommonProgressView];

}

- (void)setupCommonProgressView {
    
    UIProgressView *pro1=[[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    //设置的高度对进度条的高度没影响，整个高度=进度条的高度，进度条也是个圆角矩形
    pro1.frame=CGRectMake(30, 100, 200, 50);
    //设置进度条颜色
    pro1.trackTintColor=[UIColor blackColor];
    //设置进度默认值，这个相当于百分比，范围在0~1之间，不可以设置最大最小值
    pro1.progress=0.2;
    //设置进度条上进度的颜色
    pro1.progressTintColor=[UIColor redColor];
    //设置进度条的背景图片
    pro1.trackImage=[UIImage imageNamed:@"popover_background"];
    //设置进度条上进度的背景图片
    pro1.progressImage=[UIImage imageNamed:@"tabbar_compose_button"];
    //设置进度值并动画显示
    [self.view addSubview:pro1];
}

@end
