//
//  JYUserDefaultDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/18.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYUserDefaultDemoController.h"
#import "JYStaff.h"

@interface JYUserDefaultDemoController ()

@end

@implementation JYUserDefaultDemoController

//UserDefault不能存自定义对象，自定义去用KeydArchiver

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createStaff];
    [self readStaff];
}

- (void)readStaff
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *staff = [accountDefaults objectForKey:@"JYStaffKey"];
    BOOL done = [accountDefaults boolForKey:@"Done"];
    NSLog(@"%@,%d:",[staff objectForKey:@"name"],done);
}

- (void)createStaff
{
    NSDictionary *staff = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"june", @"name",
                               @"172",@"height",
                               @"23",@"age",
                               nil];
    //存储
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    [accountDefaults setObject:staff forKey:@"JYStaffKey"];
    [accountDefaults setBool:YES forKey:@"Done"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
