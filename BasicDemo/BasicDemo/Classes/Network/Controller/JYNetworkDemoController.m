//
//  JYNetworkDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/17.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYNetworkDemoController.h"
#import "JYItemMessage.h"
#import "JYHeader.h"

@interface JYNetworkDemoController ()

@property (strong, nonatomic) NSArray *dataList;

// 所有标题行的字典
@property (strong, nonatomic) NSMutableDictionary *sectionDict;

@end

@implementation JYNetworkDemoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 1. 初始化数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Technology" ofType:@"plist"];
    self.dataList = [NSArray arrayWithContentsOfFile:path];
    // 2. 设置标题行高
    [self.tableView setSectionHeaderHeight:44];
    // 3. 设置表格行高
    [self.tableView setRowHeight:50];
    // 4. 初始化展开折叠字典
    self.sectionDict = [NSMutableDictionary dictionaryWithCapacity:self.dataList.count];
    // 5. 给表格注册可重用标题行
    [self.tableView registerClass:[JYHeader class] forHeaderFooterViewReuseIdentifier:@"JYHeader"];
    // 6. 设置不可滑动越界
    self.tableView.bounces=NO;
    
    //分割
//  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
    
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    JYHeader *header = self.sectionDict[@(section)];
    BOOL isOpen = header.isOpen;
    
    if (isOpen) {
        // 1. 从数组中取出sction对应字典
        NSDictionary *dict = self.dataList[section];
        // 2. 返回字典中数组的数量
        NSArray *array = dict[@"friends"];
        
        return array.count;
    } else {
        return 0;
    }
}

// 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *titileString;
    titileString = [NSString stringWithFormat:@"%ld",((long)[indexPath row]+1) * 100 + (long)[indexPath section] *10000];
    NSString *name = [JYItemMessage findClassNameByID:titileString.intValue];
    NSLog(@"titlestring:%@",titileString);
    //    NSString *result = [NSString stringWithFormat:@"这个类是%@",name];
    //这个表示选中的那个cell上的数据
    id obj = [[NSClassFromString(name) alloc] init];
    NSLog(@"What is obj : %@", obj);
    [self.navigationController pushViewController:obj animated:YES];
    
    //
    //    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"事件" message:titileString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //    [alert show];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"MyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor orangeColor];
    // 1. 从数组中取出indexPath.row对应的字典
    NSDictionary *dict = self.dataList[indexPath.section];
    
    // 2. 从字典中取出对应的好友数组
    NSArray *array = dict[@"friends"];
    
    // 3. 填充表格内容
    [cell.textLabel setText:array[indexPath.row]];
    
    return cell;
}

#pragma mark 表格标题栏
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 如果要对标题栏进行优化，需要使用UITableViewHeaderFooterView类型的视图
    static NSString *HeaderID = @"JYHeader";
    
    JYHeader *header = self.sectionDict[@(section)];
    if (header == nil) {
        NSLog(@"实例化标题栏");
        
        // 实例化表格标题，一定要用initWithReuseIdentifier方法
        header = [[JYHeader alloc]initWithReuseIdentifier:HeaderID];
        
        // 设置代理
        [header setDelegate:self];
        
        // 将自定义标题栏加入字典
        [self.sectionDict setObject:header forKey:@(section)];
    }
    
    NSDictionary *dict = self.dataList[section];
    NSString *groupName = dict[@"group"];
    
    [header.button setTitle:groupName forState:UIControlStateNormal];
    
    // 在标题栏自定义视图中记录对应的分组数
    [header setSection:section];
    
    header.contentView.backgroundColor = [UIColor orangeColor];
    
    return header;
}

#pragma mark - 自定义标题栏代理方法
- (void)myHeaderDidSelectedHeader:(JYHeader *)header
{
    NSLog(@"点击按钮 %d", header.section);
    
    JYHeader *jyHeader = self.sectionDict[@(header.section)];
    
    BOOL isOpen = jyHeader.isOpen;
    [jyHeader setIsOpen:!isOpen];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:header.section] withRowAnimation:UITableViewRowAnimationFade];
}

@end
