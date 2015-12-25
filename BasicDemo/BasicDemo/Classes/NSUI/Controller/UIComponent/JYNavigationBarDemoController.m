//
//  JYNavigationBarDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/17.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYNavigationBarDemoController.h"

@interface JYNavigationBarDemoController ()

@end

@implementation JYNavigationBarDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCommonNavigationBar];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupCommonNavigationBar {
    
    // 获得UINavigationBar对象
    UINavigationBar *navBar = self.navigationController.navigationBar;
    // 设置UINavigationBar的样式 UIBarStyleDefault
    [navBar setBarStyle:UIBarStyleDefault];
    // 设置UINavigationBar为半透明
    [navBar setTranslucent:YES];
    // 自定义UINavigationBar的颜色
    [navBar setTintColor:[UIColor redColor]];
    // 设置UINavigationBar的背景颜色
    [navBar setBackgroundColor:[UIColor blackColor]];
    // 设置UINavigationBar字体颜色
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor yellowColor]
                                                     forKey:UITextAttributeTextColor];
    navBar.titleTextAttributes = dict;
    //阴影
    [navBar setShadowImage:[UIImage imageNamed:@"statusdetail_comment_background_middle_highlighted"]];
    //半透明
    [navBar setTranslucent:YES];
    // 设置标题的垂直偏移量
    [navBar setTitleVerticalPositionAdjustment:10 forBarMetrics:UIBarMetricsDefault];
}

@end
