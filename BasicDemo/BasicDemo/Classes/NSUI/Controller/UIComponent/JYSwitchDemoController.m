//
//  JYSwitchDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/16.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYSwitchDemoController.h"

@interface JYSwitchDemoController ()

@end

@implementation JYSwitchDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCommonSwitch];
}

- (void)setupCommonSwitch {

    //创建
    UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(50, 100 , 100, 40)];
    //默认状态
    switchView.on = YES;
    //事件响应
    [switchView addTarget:self action:@selector(switchAction) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:switchView];
}

- (void)switchAction {

    NSLog(@"switch");
}

@end
