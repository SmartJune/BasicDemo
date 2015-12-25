//
//  JYSQLiteDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/20.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYSQLiteDemoController.h"
#import "sqlite3.h"
#import "JYStaff.h"

@interface JYSQLiteDemoController ()

@end

@implementation JYSQLiteDemoController

static sqlite3 *_db;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createTable];
    NSLog(@"insert");
    [self insert];
    [self insert];
    NSLog(@"select");
    [self select];
    NSLog(@"update");
    [self update];
    NSLog(@"select");
    [self select];
    NSLog(@"delete");
    [self delete];
    NSLog(@"select");
    [self select];
}

//创建表
- (void)createTable {

    NSString *sql = @"create table if not exists t_staff (id integer primary key autoincrement,name text,age integer,height double);";
    [self execWithSql:sql];
}

//查
- (void)select {
    
    // 准备查询
    NSString *sql = @"select * from t_staff;";
    
    NSArray *arr = [self selectWithSql:sql];
    
    for (JYStaff *staff in arr) {
        NSLog(@"%@--%d--%lf",staff.name,staff.age,staff.height);
    }
    
}

//改
- (void)update {
    NSString *sql = @"update t_staff set name = 'june1234' where name = 'june';";
    [self execWithSql:sql];
}

//增
- (void)insert {
    
    NSString *sql = @"insert into t_staff (name,age,height) values ('june',18,172.5);";
    [self execWithSql:sql];
}

//删
- (void)delete {
    NSString *sql = @"delete from t_staff;";
    [self execWithSql:sql];
}


// 初始化数据库
+ (void)initialize
{
    // 获取cache文件夹路径
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    // 拼接文件名
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"staff.sqlite"];
    // 打开数据库，就会创建数据库文件
    // fileName保存数据库的全路径文件名
    // ppDb:数据库实例
    
    // 打开数据库
    if (sqlite3_open(filePath.UTF8String, &_db) == SQLITE_OK) {// 打开成功
        NSLog(@"数据库打开成功");
    }else{
        NSLog(@"数据库打开失败");
    }
}

//执行
- (void)execWithSql:(NSString *)sql
{
    
    char *errmsg;
    sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errmsg);
    
    if (errmsg) {
        NSLog(@"操作失败--%s",errmsg);
    }else{
        NSLog(@"操作成功");
    }
}

//查
- (NSArray *)selectWithSql:(NSString *)sql
{
    
    // 数据库语句的字节数 -1 表示自动计算字节数
    // ppStmt句柄：用来操作查询的数据
    sqlite3_stmt *stmt;
    NSMutableArray *arrM = [NSMutableArray array];
    
    if (sqlite3_prepare_v2(_db, sql.UTF8String, -1, &stmt, NULL) == SQLITE_OK) {
        
        // 准备成功
        // 执行句柄
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            int ID = sqlite3_column_int(stmt, 0);
            // 有数据
            NSString *name = [NSString stringWithUTF8String:sqlite3_column_text(stmt, 1)];
            
            int age = sqlite3_column_int(stmt, 2);
            double height = sqlite3_column_double(stmt, 3);
            
            JYStaff *staff = [[JYStaff alloc]init];
            staff.name = name;
            staff.age = age;
            staff.height = height;
            
            [arrM addObject:staff];
        }
    }
    return arrM;
}


@end
