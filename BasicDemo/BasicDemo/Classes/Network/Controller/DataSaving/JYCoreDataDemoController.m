//
//  JYCoreDataDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/20.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYCoreDataDemoController.h"
#import "CoreData/CoreData.h"
#import "Staff.h"

@interface JYCoreDataDemoController (){

    NSManagedObjectContext *_context;
}

@end

@implementation JYCoreDataDemoController

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

-(void)initDataBase {

    // 上下文
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
    // 上下文关连数据库
    // model模型文件
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    // 持久化存储调度器
    // 持久化，把数据保存到一个文件
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    // 告诉Coredata数据库的名字和路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *sqlitePath = [doc stringByAppendingPathComponent:@"staff.sqlite"];
    NSLog(@"%@",sqlitePath);
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlitePath] options:nil error:nil];
    
    context.persistentStoreCoordinator = store;
    _context = context;
}

//增
-(void)insert{
    
    // 创建一个员工对象
    Staff *staff = [NSEntityDescription insertNewObjectForEntityForName:@"Staff" inManagedObjectContext:_context];
    staff.name = @"june";
    staff.age = @16;
    staff.height = @170;
    
    // 直接保存数据库
    NSError *error = nil;
    [_context save:&error];
    
    if (error) {
        NSLog(@"%@",error);
    }
}

//查
-(void)select{
    
    // FectchRequest 抓取请求对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Staff"];
    // 设置过滤条件
//    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",
//                        @"june"];
//    request.predicate = pre;
    
    // 设置排序
    NSSortDescriptor *heigtSort = [NSSortDescriptor sortDescriptorWithKey:@"height" ascending:NO];
    request.sortDescriptors = @[heigtSort];
    // 执行请求
    NSError *error = nil;
    NSArray *staffs = [_context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"error");
    }
    
    //遍历
    for (Staff *staff in staffs) {
        NSLog(@"名字 %@ 身高 %@ 年龄 %@",staff.name,staff.height,staff.age);
    }
    
}

//改
-(void)update{
    // FectchRequest 抓取请求对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Staff"];
    // 设置过滤条件
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",
                        @"june"];
    request.predicate = pre;
    // 执行请求
    NSArray *staffs = [_context executeFetchRequest:request error:nil];
    // 更新
    for (Staff *staff in staffs) {
        staff.height = @199.125;
    }
    // 保存
    [_context save:nil];
}

//删
-(void)delete{
    // FectchRequest 抓取请求对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Staff"];
    
    // 设置过滤条件
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",
                        @"june"];
    request.predicate = pre;
    
    // 执行请求
    NSArray *staffs = [_context executeFetchRequest:request error:nil];
    
    // 删除
    for (Staff *staff in staffs) {
        [_context deleteObject:staff];
    }
    // 保存
    [_context save:nil];
    
}

@end
