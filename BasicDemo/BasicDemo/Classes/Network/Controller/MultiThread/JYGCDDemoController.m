//
//  JYGCDDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/18.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYGCDDemoController.h"

@interface JYGCDDemoController ()

@end

@implementation JYGCDDemoController

//evernote 博客准备-gcd 之前写的笔记

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self gcdTest12];
}

//延时执行
- (void)gcdTest12
{
    // 参数： when : 表示从现在开始，经过多少秒以后
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC));
    
    // queue ：  在哪一个队列里面执行后面的任务
    dispatch_after(when, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"点我了-- %@", [NSThread currentThread]);
    });

}

//线程间通信
- (void)gcdTest11
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"%@", [NSThread currentThread]);
        // 耗时操作: 放在全局队列，异步执行
        // 1. url, 确定一个网络上的资源路径
        NSURL *url = [NSURL URLWithString:@"http://fe.topit.me/e/d1/12/1170068721aa112d1el.jpg"];
        
        // 2. 通过url可以下载对应的网络资源, 网络资源传输的都是二进制
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        // 3. 二进制转成图片
        UIImage *image = [UIImage imageWithData:data];
        
        // 4. 更新UI，在主线程-》 直接把任务添加到主队列，就会在主队列执行
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"-----%@   image:%@", [NSThread currentThread],image);
            
        });
    });

}

//队列组
- (void)gcdTest10
{
    // 实例化一个调度组
    dispatch_group_t group = dispatch_group_create();
    // 队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    // 任务添加到队列queue
    dispatch_group_async(group, queue, ^{
        NSLog(@"拿饭---%@", [NSThread currentThread]);
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"点菜---%@", [NSThread currentThread]);
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"端汤---%@", [NSThread currentThread]);
    });
    //注意点： 在调度组完成通知里，可以跨队列通信
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 更新UI，在主线程
        NSLog(@"搞定，开饭%@", [NSThread currentThread]); // 异步
    });
}

//只执行一次
- (void)gcdTest9
{
    static dispatch_once_t onceToken;
    NSLog(@"%ld", onceToken);
    
    dispatch_once(&onceToken, ^{
        NSLog(@"%----ld", onceToken);
        
        NSLog(@"真的执行一次么？");
    });
    NSLog(@"完成");

}

/**
 全局队列跟并发队列的区别
 1. 全局队列没有名称 并发队列有名称
 2. 全局队列，是供所有的应用程序共享。
 */
- (void)gcdTest8
{
    // 获得全局队列
    /**
     参数：第一个参数，iOS7和8的枚举默认优先级都是0，但是名字不一样，所以直接写0
     第二个参数：保留参数 0
     */
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    // 添加异步任务
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
    }
}

//同步异步
- (void)gcdTest7
{
    // 并发队列
    dispatch_queue_t  queue = dispatch_queue_create("cz", DISPATCH_QUEUE_CONCURRENT);
    
    // 添加任务
    // 同步任务，需要马上执行。 不开新线程
    dispatch_sync(queue, ^{
        NSLog(@"登录 %@", [NSThread currentThread]);
    });
    //
    dispatch_async(queue, ^{
        NSLog(@"发邮件给端丹 %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"发邮件给国演 %@", [NSThread currentThread]);
    });
}

/**
 主队列：专门负责在主线程上调度任务，不会在子线程调度任务，在主队列不允许开新线程.
 同步执行：要马上执行
 结果：死锁
 */
- (void)gcdTest6
{
    // 1. 获得主队列-> 程序启动，--> 至少有一个主线程-> 一开始就会创建主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    NSLog(@"1----");
    
    // 2. 同步执行任务
    for (int i = 0; i < 10; i++) {
        NSLog(@"调度前---");
        // 同步：把任务放到主队列里，但需是马上执行
        dispatch_sync(queue, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
        NSLog(@"睡会");
        [NSThread sleepForTimeInterval:2.0];
    }
    NSLog(@"完成----");
    
}

/**
 主队列：专门负责在主线程上调度任务，不会在子线程调度任务，在主队列不允许开新线程.
 异步执行： 会开新线程，在新线程执行
 结果: 不开线程， 只能在主线程上面，顺序执行!
 */
- (void)gcdTest5
{
    // 1. 获得主队列-> 程序启动，--> 至少有一个主线程-> 一开始就会创建主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    NSLog(@"1----");
    
    // 2. 异步执行任务
    for (int i = 0; i < 10; i++) {
        NSLog(@"调度前---");
        // 异步：把任务放到主队列里，但是不需要马上执行
        dispatch_async(queue, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
        NSLog(@"睡会");
        [NSThread sleepForTimeInterval:2.0];
    }
    NSLog(@"完成----");
}

/**
 并发队列：可以同时执行多个任务
 同步任务：不会开辟新线程，是在当前线程执行
 结果：不开新线程，顺序一个一个执行。
 */
- (void)gcdTest4
{
    //1. 并行队列
    dispatch_queue_t queue = dispatch_queue_create("cz", DISPATCH_QUEUE_CONCURRENT);
    
    // 2. 同步执行任务
    for (int i = 0; i < 10; i++) {
        dispatch_sync(queue, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
    }
}

/**
 并发队列：可以同时执行多个任务
 异步执行：肯定会开新线程，在新线程执行
 结果：会开很多个线程，同时执行
 */
- (void)gcdTest3
{
    //1. 并行队列
    dispatch_queue_t queue = dispatch_queue_create("cz", DISPATCH_QUEUE_CONCURRENT);
    
    // 2. 异步执行任务
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
    }
}

/**
 串行队列：一个一个执行
 异步执行：肯定会开新线程，在新线程执行
 结果：只会开一个线程，而且所有任务都在这个新的线程里面执行
 */
- (void)gcdTest2
{
    // 1. 串行队列
    // 下面两种写法是一样的
    //    dispatch_queue_t queue = dispatch_queue_create("PingAn", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue = dispatch_queue_create("PingAn", NULL);
    
    
    // 2. 异步执行
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
    }
}


/**
 串行队列：顺序，一个一个执行
 同步任务：不会开辟新线程，是在当前线程执行
 结果：不开新线程，在当前线程顺序执行
 
 dispatch : 调度，GCD里面函数，都是以dispatch开头的
 */
- (void)gcdTest1
{
    // 1. 创建一个串行队列
    //参数：1. 队列标签 2. 队列的属性
    dispatch_queue_t queue = dispatch_queue_create("itcast", DISPATCH_QUEUE_SERIAL);
    
    NSLog(@"开始!!");
    
    // 2. 同步执行任务
    // 一般只要使用”同步“执行，串行队列对添加的同步任务，会立马执行
    dispatch_sync(queue, ^{
        NSLog(@"%@", [NSThread currentThread]);
    });
    
    NSLog(@"完成!!");
}

@end
