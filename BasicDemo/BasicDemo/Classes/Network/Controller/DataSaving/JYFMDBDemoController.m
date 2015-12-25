//
//  JYFMDBDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/21.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYFMDBDemoController.h"
#import "FMDB.h"

@interface JYFMDBDemoController ()

@property (nonatomic, strong) FMDatabaseQueue *queue;

@end

@implementation JYFMDBDemoController

/*
它是什么：
FMDB是iOS平台的SQLite数据库框架
FMDB以OC的方式封装了SQLite的C语言API
为什么要用它：
使用起来更加面向对象，省去了很多麻烦、冗余的C语言代码
对比苹果自带的Core Data框架，更加轻量级和灵活
提供了多线程安全的数据库操作方法，有效地防止数据混乱
*/

//删
- (void)delete {
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL flag = [db executeUpdate:@"delete from t_user;"];
        if (flag) {
            NSLog(@"delete success");
        }else{
            NSLog(@"failure");
        }
    }];
}

//增
- (void)insert {
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL flag = [db executeUpdate:@"insert into t_user (name,money) values (?,?)",@"a",@1000];
        if (flag) {
            NSLog(@"insert success");
        }else{
            NSLog(@"failure");
        }
    }];
}

//改
- (void)update {
    [_queue inDatabase:^(FMDatabase *db) {
        // 开启事务
        [db beginTransaction];
        BOOL flag = [db executeUpdate:@"update t_user set money = ? where name = ?;",@500,@"a"];
        if (flag) {
            NSLog(@"update success");
        }else{
            NSLog(@"failure");
            // 回滚
            [db rollback];
        }
        // 全部操作完成时候再去
        [db commit];
    }];
}

//查
- (void)select {
    
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *result =   [db executeQuery:@"select * from t_user"];
        while ([result next]) {
            NSString *name = [result stringForColumn:@"name"];
            int money = [result intForColumn:@"money"];
            NSLog(@"%@--%d",name,money);
        }
    }];
}

//初始化数据库
- (void)initDataBase {

    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    // 拼接文件名
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"user.sqlite"];
    // 创建数据库实例
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    _queue = queue;
    // 创建数据库表
    // 提供了一个多线程安全的数据库实例
    [queue inDatabase:^(FMDatabase *db) {
        BOOL flag =  [db executeUpdate:@"create table if not exists t_user (id integer primary key autoincrement,name text,money integer)"];
        if (flag) {
            NSLog(@"init success");
        }else{
            NSLog(@"failure");
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataBase];
    [self insert];
    [self select];
    [self update];
    [self select];
    [self delete];
    [self select];
}


@end
