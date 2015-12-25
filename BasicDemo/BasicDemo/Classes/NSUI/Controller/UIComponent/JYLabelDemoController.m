//
//  JYLabelDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/15.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYLabelDemoController.h"

@interface JYLabelDemoController ()

@end

@implementation JYLabelDemoController

//多行文本

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupCommonLabel];
}

- (void)setupCommonLabel {

    //基本属性
    //创建
    UILabel *myLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 220, 44)];
    UILabel *myLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 220, 44)];
    UILabel *myLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 220, 44)];
//    UILabel *myLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 120, 44)];
    //添加
    [self.view addSubview:myLabel1];
    [self.view addSubview:myLabel2];
    [self.view addSubview:myLabel3];
//    [self.view addSubview:myLabel4];
    
    //文字
    //默认文本
    myLabel1.text = @"texttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttext";
    //设置字体
    myLabel1.font = [UIFont systemFontOfSize:10];
    //设置颜色
    myLabel1.textColor = [UIColor blueColor];
    //对齐方式
    myLabel1.textAlignment = NSTextAlignmentCenter;
    //行数
    myLabel1.numberOfLines = 2;
    //裁剪方式
    myLabel1.lineBreakMode = NSLineBreakByTruncatingMiddle;
    //enabled属性
    myLabel1.enabled = NO;
    
    //关键字标红
    //基本文本
    NSString *keyword = @"Attributed";
    NSString *result = @"NSMutableAttributedString";
    // 设置标签文字
    NSMutableAttributedString *attrituteString = [[NSMutableAttributedString alloc] initWithString:result];
    // 获取标红的位置和长度
    NSRange range = [result rangeOfString:keyword];
    // 设置标签文字的属性
    [attrituteString setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor],   NSFontAttributeName : [UIFont systemFontOfSize:17]} range:range];
    // 显示在Label上
    myLabel2.attributedText = attrituteString;
    
    myLabel3.text = @"String";
    //根据文本宽度调整字体大小
    myLabel3.adjustsFontSizeToFitWidth = YES;
    //阴影
    myLabel3.shadowColor = [UIColor grayColor];
    myLabel3.shadowOffset = CGSizeMake(1, 1);
    //改变字母之间的间距来适应label大小
    myLabel3.adjustsLetterSpacingToFitWidth = YES;
    //对齐基线
    myLabel3.adjustsFontSizeToFitWidth = YES;
    myLabel3.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;

    
}

@end
