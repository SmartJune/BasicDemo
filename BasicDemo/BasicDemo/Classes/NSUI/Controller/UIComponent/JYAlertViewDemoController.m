//
//  JYAlertViewDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/16.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYAlertViewDemoController.h"

@interface JYAlertViewDemoController ()

@end

@implementation JYAlertViewDemoController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(100, 100, 100, 40);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(setupCommonAlertView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)setupCommonAlertView {
    
    //创建
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"CD-KEY"
                           
                                                    message:@"please enter cd-key："
                           
                                                   delegate:self
                           
                                          cancelButtonTitle:@"Cancel"
                           
                                          otherButtonTitles:@"Ok",nil];
    [alert setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    
    UITextField * text1 = [alert textFieldAtIndex:0];
    
    UITextField * text2 = [alert textFieldAtIndex:1];
    
    text1.keyboardType = UIKeyboardTypeNumberPad;
    
    text2.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 0) {
        [self setupCommonAlertView];
    }
}

@end
