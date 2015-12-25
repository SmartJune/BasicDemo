//
//  JYOperationDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/18.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYOperationDemoController.h"

@interface JYOperationDemoController ()

@property (nonatomic,strong) NSOperationQueue *opQueue;

@end

@implementation JYOperationDemoController

// 懒加载的方式，初始化NSOperationQueue对象
- (NSOperationQueue *)opQueue
{
    if (_opQueue == nil) {
        _opQueue = [[NSOperationQueue alloc] init];
    }
    return _opQueue;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self opDemo8];
}

// 依赖关系
- (void)opDemo8
{
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1. 拿饭卡，去食堂排队, %@",[NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2. 点菜, %@",[NSThread currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"3. 吃饭, %@",[NSThread currentThread]);
    }];
    
    // 指定任务之间的依赖关系 -- 依赖关系可以跨队列(可以在子线程下载完，到主线程更新UI)
    [op2 addDependency:op1];
    [op3 addDependency:op2];
    
    // YES 等待上面的操作执行结束，再 执行  NSLog(@"come here")
    [self.opQueue addOperations:@[op1, op2] waitUntilFinished:YES];
    
    // 在主线程更新UI
    [[NSOperationQueue mainQueue] addOperation:op3];
    NSLog(@"come here");
}

// 挂起和取消
- (void)opDemo7
{
    // 取消队列的所有操作
    [self.opQueue cancelAllOperations]; // 取消队列的所有操作，会把任务从队列里面全部删除
    // 暂停继续
    self.opQueue.suspended = !self.opQueue.suspended;
}

//最大并发数
- (void)opDemo6
{
    // 设置最大的并发数是2 (最大并发数，不是线程的数量。 而是同时执行的操作的数量)
    self.opQueue.maxConcurrentOperationCount = 2;
    for (int i = 0; i < 20; i++) {
        NSOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            
            [NSThread sleepForTimeInterval:1.0];
            
            NSLog(@"%@---%d", [NSThread currentThread], i);
        }];
        [self.opQueue addOperation:op];
    }
}

//线程间通信
- (void)opDemo5
{
    NSOperationQueue *q = [[NSOperationQueue alloc]init];
    [q addOperationWithBlock:^{
        NSLog(@"耗时操作....%@", [NSThread currentThread]);
        // 在主线程更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"更新UI....%@", [NSThread currentThread]);
        }];
    }];
}

//NSBlockOperation更简单的使用
- (void)opDemo4
{
    // 队列
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    
    for (int i = 0; i < 10; i++) {
        // 不创建操作对象，使用addOperationWithBlock:直接添加操作到队列
        [q addOperationWithBlock:^{
            NSLog(@"%@---%d", [NSThread currentThread], i);
        }];
    }
    
    // 创建并添加一个 NSBlockOperation
    NSBlockOperation * op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op1 --- %@", [NSThread currentThread]);
        
    }];
    
    [op1 addExecutionBlock:^{
        NSLog(@"op1-1");
    }];
    
    [q addOperation:op1];
    
    // 创建并添加一个 NSInvocationOperation
    NSOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@"Invocation"];
    [q addOperation:op2];
}

// NSBlockOperation使用
- (void)opDemo3
{
    // 主队列
    NSOperationQueue *q = [NSOperationQueue mainQueue];
    
    // 多个操作
    for (int i = 0; i < 10; i++) {
        NSBlockOperation * op = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"%@---%d", [NSThread currentThread], i);
        }];
        // 把block操作放到队列
        [q addOperation:op];
    }
    
    NSLog(@"完成");
}

// 多个NSInvocationOperation使用
- (void)opDemo2
{
    // NSOperationQueue队列，本质就是GCD里面的并发队列
     NSOperationQueue *q = [[NSOperationQueue alloc] init];
    
    // 把多个操作放到队列
    for (int i = 0 ; i < 10; i++)
    {
        NSOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@"Invocation"];
        
        // 把block操作放到队列
        [q addOperation:op];
    }
}

// 单个NSInvocationOperation使用
- (void)opDemo1
{
    // 1. 创建操作
    NSOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@"Invocation"];
    
    // 2. 启动-- 直接在当前线程执行任务
    //    [op start];
    // 2. 放到队列
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    // 只要把操作添加到队列， ---会自动异步执行调度方法
    [q addOperation:op];
}

#pragma mark - 耗时操作
- (void)downloadImage:(id)obj
{
    NSLog(@"%@---%@", [NSThread currentThread], obj);
}

@end
