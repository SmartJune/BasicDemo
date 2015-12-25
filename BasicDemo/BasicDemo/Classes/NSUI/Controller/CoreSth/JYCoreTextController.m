//
//  JYCoreTextController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/23.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYCoreTextController.h"
#import "JYCoreText.h"

@interface JYCoreTextController ()

@end

@implementation JYCoreTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    JYCoreText *myText = [[JYCoreText alloc]initWithFrame:CGRectMake(0.0, 60, 320.0, 440.0)];
    myText.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:myText];

}



@end
