//
//  JYKV_DemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/23.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYKV_DemoController.h"

@interface JYKV_DemoController ()

@end

@implementation JYKV_DemoController


//-(id)init:(PingAnStaff *)staff
//{
//    if (self = [super init]) {
//        _staff = staff;
//        
//        [_staff addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
//    }
//    return self;
//    
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加监听
    self.staff = [[PingAnStaff alloc]init];
    [_staff addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    [_staff addObserver:self forKeyPath:@"weight" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self change];
    [self validate];
}

//KVV验证
-(void)validate
{
    NSString *weight = @"34.0";
    BOOL isEqual = [self.staff validateValue:&weight forKey:@"weight" error:nil];
    if(isEqual){
        NSLog(@"weight validate succeed");
    }
    
    NSString *name = @"junen";
    BOOL nameEqual = [self.staff validateValue:&name forKey:@"name" error:nil];
    if(nameEqual){
        NSLog(@"name validate failed");
    }
}

//修改对象属性
-(void)change
{
    //两种方法触发监听
    NSDictionary *newBookPropertiesDictionary=[NSDictionary dictionaryWithObjectsAndKeys:
                                               @"june",@"name",
                                               @"20.5",@"age",nil];
    [self.staff setValuesForKeysWithDictionary:newBookPropertiesDictionary];
    
    //可以修改私有变量
    [self.staff setValue:@"34.0" forKey:@"weight"];
}

//释放时要移除监听
-(void)dealloc
{
    //移除监听
    [_staff removeObserver:self forKeyPath:@"age"];
    [_staff removeObserver:self forKeyPath:@"weight"];
}

//实现监听
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqual:@"age"]||[keyPath isEqual:@"weight"]) {
        NSLog(@"old: %@",[change objectForKey:@"old"]);
        NSLog(@"new: %@",[change objectForKey:@"new"]);
    }
}

@end
