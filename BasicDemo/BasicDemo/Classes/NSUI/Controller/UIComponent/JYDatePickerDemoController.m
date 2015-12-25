//
//  JYDatePickerDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/17.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYDatePickerDemoController.h"

@interface JYDatePickerDemoController ()

@end

@implementation JYDatePickerDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupCommonDatePicker];
}

- (void)setupCommonDatePicker {
    //宽高奔来就是固定的
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    //设置区域为中国简体中文
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    //设置picker的显示模式：只显示日期
    datePicker.datePickerMode = UIDatePickerModeDate;
    //监听
    [datePicker addTarget:self action:@selector(dateChange)forControlEvents:UIControlEventValueChanged];
    //日期范围
    NSDate* minDate = [self convertDateFromString:@"1900-01-01"];
    NSDate* maxDate = [self convertDateFromString:@"2099-01-01"];
    datePicker.minimumDate = minDate;
    datePicker.maximumDate = maxDate;
    //默认日期
    datePicker.date = minDate;
    //动画跳到指定日期
    [datePicker setDate:maxDate animated:YES];
    
    [self.view addSubview:datePicker];
}

- (NSDate*) convertDateFromString:(NSString*)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[formatter dateFromString:dateString];
    return date;
}

- (void)dateChange {

    NSLog(@"date change");
}


@end
