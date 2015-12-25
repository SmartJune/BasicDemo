//
//  JYTabBarController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/15.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYTabBarController.h"
#import "JYNSUIViewController.h"
#import "JYNavigationController.h"
#import "JYNetworkDemoController.h"

@interface JYTabBarController ()

@end

@implementation JYTabBarController

+ (void)initialize
{
    // 获取当前这个类下面的所有tabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    // 创建属性字典
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    // 设置模型的标题属性修改控件的文字颜色
    [item setTitleTextAttributes:att forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加所有子控制器
    [self setUpAllChildViewController];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


#pragma mark - 添加所有的子控制器
- (void)setUpAllChildViewController
{
    // NSUI
    JYNSUIViewController *nsui = [[JYNSUIViewController alloc] init];
    [self setUpOneChildViewController:nsui image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"NS&UI"];
    nsui.view.backgroundColor = [UIColor orangeColor];

    // 网络多线程
    JYNetworkDemoController *network = [[JYNetworkDemoController alloc] init];
    [self setUpOneChildViewController:network image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"Network"];
    network.view.backgroundColor = [UIColor orangeColor];
}

#pragma mark - 添加一个子控制器
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    
    JYNavigationController *nav = [[JYNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}


@end
