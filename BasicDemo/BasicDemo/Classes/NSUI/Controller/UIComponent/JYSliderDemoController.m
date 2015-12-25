//
//  JYSliderDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/16.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYSliderDemoController.h"

@interface JYSliderDemoController ()

@end

@implementation JYSliderDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCommonSlider];
}

- (void)setupCommonSlider {
    //创建&添加
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(0, 400,320 , 40)];

    //上限下限
    slider.maximumValue = 100.0;
    slider.minimumValue = 0.0;
    //默认值
    slider.value = 30.0;
    //左右边的图片
    slider.minimumValueImage = [UIImage imageNamed:@"navigationbar_more_highlighted"];
    slider.maximumValueImage = [UIImage imageNamed:@"navigationbar_more_highlighted"];
    
    [slider setMinimumTrackImage:[UIImage imageNamed:@"navigationbar_pop"] forState:UIControlStateNormal];
    [slider currentMinimumTrackImage];//获取
    [slider setMaximumTrackImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] forState:UIControlStateNormal];
    [slider currentMaximumTrackImage];//获取
    //滑块样子
    [slider thumbImageForState:UIControlStateNormal];
    [slider setThumbImage:[UIImage imageNamed:@"avatar_default"] forState:UIControlStateHighlighted];//设置了高亮状态的滑轮样式
    slider.thumbTintColor = [UIColor redColor];//设置了滑轮的颜色如果设置了滑轮的样式图片就不会显示
    
    //监听
    [slider addTarget:self action:@selector(sliderListener) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}

- (void)sliderListener {
    NSLog(@"nothing");
}

@end
