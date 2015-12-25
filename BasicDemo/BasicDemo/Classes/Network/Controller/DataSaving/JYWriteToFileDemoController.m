//
//  JYWriteToFileDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/18.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYWriteToFileDemoController.h"

@interface JYWriteToFileDemoController ()

@end

@implementation JYWriteToFileDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self write];
    [self read];
}

- (void)write
{
    NSString *string = @"i am a staff of ping an, my name is june";
    
    //writeToFile
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectoryPath = [path objectAtIndex:0];
    NSString *filePath = [cachesDirectoryPath stringByAppendingPathComponent:@"staff.txt"];
    
    //writeToURL
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"staff2" withExtension:@"txt"];
    NSURL *url2 = [NSURL fileURLWithPath:filePath];
    
    [string writeToFile:filePath atomically:YES];
    [string writeToURL:url2 atomically:YES];
    
}

- (void)read
{
    
    //writeToFile
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectoryPath = [path objectAtIndex:0];
    NSString *filePath = [cachesDirectoryPath stringByAppendingPathComponent:@"staff.txt"];
    
    NSString *readString = [NSString stringWithContentsOfFile:filePath];
    NSLog(@"%@",readString);
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
