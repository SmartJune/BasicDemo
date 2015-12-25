//
//  JYTableViewDemoControllerTableViewController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/16.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYTableViewDemoController.h"
#import "Message.h"
#import "ChatCell.h"

// 聊天行的可重用标示符
static NSString *ID = @"ChatCell";

@interface JYTableViewDemoController ()

@property (strong, nonatomic) NSArray *dataList;

@end

@implementation JYTableViewDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 初始化数据
    NSString *path = [[NSBundle mainBundle]pathForResource:@"messages" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *data = [NSMutableArray arrayWithCapacity:array.count];
    
    for (NSDictionary *dict in array) {
        Message *m = [Message messageWithContent:dict[@"content"] fromSelf:[dict[@"fromSelf"]boolValue]];
        
        [data addObject:m];
    }
    
    self.dataList = data;
    
    // 2. 注册可重用单元格
    [self.tableView registerClass:[ChatCell class] forCellReuseIdentifier:ID];
    // 取消分隔线
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 从缓存池查找可重用单元格
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 设置单元格内容
    Message *message = self.dataList[indexPath.row];
    
    [cell setMessage:message];
    
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 千万注意，在这里不能调用cell，否则会死循环
    // 需要根据文本的实际内容，重新计算表格行的高度
    Message *message = self.dataList[indexPath.row];
    
    CGSize size = [message.content sizeWithFont:[UIFont systemFontOfSize:18]
                              constrainedToSize:CGSizeMake(180, 10000)];
    CGFloat height = size.height + 30;
    
    height = height > 80 ? height : 80;
    
    return height;
}

@end
