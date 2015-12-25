
//
//  JYKeyedArchiverController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/18.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYKeyedArchiverController.h"
#import "JYStaff.h"

@interface JYKeyedArchiverController ()

@end

@implementation JYKeyedArchiverController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createStaff];
    [self readStaff];
}

- (void)readStaff
{
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path = [document stringByAppendingPathComponent:@"staff.archiver"];
  
    JYStaff *staff = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"%d:,%@:,%f:",staff.age,staff.name,staff.height);
}

- (void)createStaff
{
    JYStaff *staff = [[JYStaff alloc]init];
    staff.age = 20;
    staff.name = @"June";
    staff.height = 172.5;
    
    //存储
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path = [document stringByAppendingPathComponent:@"staff.archiver"];
    [NSKeyedArchiver archiveRootObject:staff toFile:path];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
