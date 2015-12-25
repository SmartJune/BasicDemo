//
//  JYPThreadDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/17.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYPThreadDemoController.h"
#import "pthread.h"

@interface JYPThreadDemoController ()

@end

@implementation JYPThreadDemoController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self test];
}

// 函数
void *run(void *param)
{
    NSString *str = (__bridge NSString *)(param);
    // 耗时操作
    for (int i = 0; i < 20000; i++) {
        NSLog(@"%@----%@", [NSThread currentThread], str);
    }
    
    return NULL;
}

// 使用pthread创建线程
- (void)test
{
    // 声明一个线程变量
    pthread_t threadId;    
    id str = @"hello";
    
    // id需要转成void *，在ARC里，需要使用__bridge 进行桥联
    // 1. 这里只是临时把str对象转成void *在这里临时使用。 不改变这个对象（str）的所有权。
    // 2. 把对象的所有权交出去，在这个函数把str转成void *
    pthread_create(&threadId, NULL, run, (__bridge void *)(str));
}

@end
