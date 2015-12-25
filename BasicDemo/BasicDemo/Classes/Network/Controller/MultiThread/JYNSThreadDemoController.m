//
//  JYNSThreadDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/17.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYNSThreadDemoController.h"

@interface JYNSThreadDemoController ()

@end

@implementation JYNSThreadDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self test];
}

- (void)test
{
    // 1. 新建一个线程
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run2) object:nil];
    
    // 2. 放到可调度线程池，等待被调度。 这时候是就绪状态
    [thread start];
}

// 带对象的耗时方法
- (void)run:(NSString *)str
{
    for (int i = 0; i < 10; i++) {
        NSLog(@"%@--%d", [NSThread currentThread], i);
    }
}

//最后一个改背景色的设置会生效，只有最后一个，why
- (void)run2
{
    NSLog(@"%s", __func__);
    // 睡2秒
    NSLog(@"%@",self);
    [NSThread sleepForTimeInterval:2.0];
    NSLog(@"1");
    self.view.backgroundColor = [UIColor greenColor];
    for (int i = 0; i < 5; i++) {
        // 满足某一个条件以后，阻塞线程的执行。 也就是让线程休息一会
        if (i == 2) {
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"2");
            self.view.backgroundColor = [UIColor redColor];
        }
        
        // 一旦达到某一个条件，就强制终止线程的执行
        if (i == 99) {
            [NSThread exit];
        }
    }
    // 睡到指定的时间点
    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:3.0]];
    self.view.backgroundColor = [UIColor blueColor];
    NSLog(@"线程结束");
}

//线程优先级,体验不明显
- (void)test4
{
    NSThread *threadA = [[NSThread alloc] initWithTarget:self selector:@selector(run:) object:@"hello"];
    threadA.name = @"thraed A";
    // 线程优先级
    threadA.threadPriority = 0.1;
    // 开始工作
    [threadA start];
    NSThread *threadB = [[NSThread alloc] initWithTarget:self selector:@selector(run:) object:@"hello"];
    threadB.name = @"thraed B";
    threadB.threadPriority = 1.0;
    [threadB start];
}

// 创建线程方式3
- (void)test3
{
    // “隐式”创建线程方式
    [self performSelectorInBackground:@selector(run:) withObject:@"cz"];
}

// 创建线程方式2
- (void)test2
{
    NSLog(@"---%@", [NSThread currentThread]);
    [NSThread detachNewThreadSelector:@selector(run:) toTarget:self withObject:@"hello"];
    NSLog(@"test2 --- %@", [NSThread currentThread]);
}

// 创建线程方式1
- (void)test1
{
    // 实例化一个线程对像
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    
    // 让线程开始工作，启动线程, 在新开的线程执行run方法
    [thread start];
    
}

@end
