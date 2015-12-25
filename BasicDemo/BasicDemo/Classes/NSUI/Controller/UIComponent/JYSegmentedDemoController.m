//
//  JYSegmentedDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/16.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYSegmentedDemoController.h"

@interface JYSegmentedDemoController ()

@end

@implementation JYSegmentedDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCommonSegment];
}

- (void)setupCommonSegment {
    //内容数组
    NSArray *array = [[NSArray alloc]initWithObjects:@"周一",@"周二",@"周三三三",@"周四",@"周五",@"周五",@"周五",nil];
    //创建
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:array];
    //根据内容调整宽度
    [segment setApportionsSegmentWidthsByContent:YES];
    //frame
    segment.frame = CGRectMake(10, 400, 320, 40);
    //设置下标为3的segment的标题 下标以0开始 IOS里的所有下标都是以0开始
    [segment setTitle:@"三了个三的" forSegmentAtIndex:2];
    //设置下标为4的segment的图片
    [segment setImage:[UIImage imageNamed:@"app"] forSegmentAtIndex:4];
    //插入图片版
    [segment insertSegmentWithImage:[UIImage imageNamed:@"album"] atIndex:2 animated:YES];
    //设置标题
    [segment insertSegmentWithTitle:@"我是周0" atIndex:0 animated:YES];
    [segment numberOfSegments];//得到segment的数量
//    [segment removeAllSegments];//移出所有segment
    //移出下标为2的segment
    [segment removeSegmentAtIndex:2 animated:YES];
    //初始化时选中
    segment.selectedSegmentIndex = 0;
    //默认为NO 当设置为YES时，当被选中后，一会儿后不显示被选中状态(最左边的样子)，不选中状态即下图的右边几个按钮一样
    segment.momentary = YES;
    //样式
    segment.segmentedControlStyle = UISegmentedControlStyleBar;
//    [segment setEnabled:NO]; //设置segment是否可用 此方法是其父类UIControl的方法
    [segment setEnabled:NO forSegmentAtIndex:2];//设置下标为2的segment不可用
    [segment setWidth:40 forSegmentAtIndex:4]; //这时下表为2的segment的宽度
    //设置内容偏移
    [segment setContentOffset:CGSizeMake(10, 10) forSegmentAtIndex:2];
    
    [self.view addSubview:segment];

}

@end
