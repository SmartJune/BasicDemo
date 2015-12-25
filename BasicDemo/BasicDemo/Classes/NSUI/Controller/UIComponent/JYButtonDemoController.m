//
//  JYButtonDemoViewController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/15.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYButtonDemoController.h"

@interface JYButtonDemoController ()

@end

@implementation JYButtonDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCommonButton];
}

- (void)setupCommonButton {
    
    //基本属性
    //创建
    UIButton *commonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //添加按钮
    [self.view addSubview:commonButton];
    //设置位置和尺寸
    commonButton.frame = CGRectMake(100, 100, 100, 100);
    //监听点击
    [commonButton addTarget:self action:@selector(commonButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //默认状态下属性
    //默认状态背景
    [commonButton setBackgroundImage:[UIImage imageNamed:@"tabbar_discover"] forState:UIControlStateNormal];
    //默认状态文字
    [commonButton setTitle:@"点我试试？" forState:UIControlStateNormal];
    //默认状态文字颜色
    [commonButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    
    //高亮状态下属性
    //高亮状态背景
    [commonButton setBackgroundImage:[UIImage imageNamed:@"tabbar_discover_selected"] forState:UIControlStateHighlighted];
    //高亮状态文字
    [commonButton setTitle:@"点你咋滴？" forState:UIControlStateHighlighted];
    //高亮状态文字颜色
    [commonButton setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
}

- (void)commonButtonClick {
    NSLog(@"common button clicked");
}

@end
