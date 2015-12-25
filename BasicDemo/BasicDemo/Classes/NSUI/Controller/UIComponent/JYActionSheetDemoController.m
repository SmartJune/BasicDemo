//
//  JYActionSheetDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/16.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYActionSheetDemoController.h"

@interface JYActionSheetDemoController ()

@end

@implementation JYActionSheetDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(100, 100, 100, 40);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(setupCommonActionSheet) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)setupCommonActionSheet {

    //创建
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"title,nil时不显示"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"确定"
                                  otherButtonTitles:@"第一项", @"第二项",nil];
    //style
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
    //如果被遮挡，用这个
//    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

//显示选项
-(void)showAlert:(NSString *)msg {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Action Sheet选择项"
                          message:msg
                          delegate:self
                          cancelButtonTitle:@"确定"
                          otherButtonTitles: nil];
    [alert show];
}

//代理 获取按钮
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self showAlert:@"确定"];
    }else if (buttonIndex == 1) {
        [self showAlert:@"第一项"];
    }else if(buttonIndex == 2) {
        [self showAlert:@"第二项"];
    }else if(buttonIndex == 3) {
        [self showAlert:@"取消"];
    }
    
}

@end
