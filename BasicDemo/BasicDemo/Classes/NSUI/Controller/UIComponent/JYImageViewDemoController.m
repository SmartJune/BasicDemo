//
//  JYImageViewDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/16.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYImageViewDemoController.h"

@interface JYImageViewDemoController ()

@property UIImageView *imageView;

@end

@implementation JYImageViewDemoController

@synthesize imageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCommonImageView];
}

- (void)setupCommonImageView {
    
    //创建
    imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"new_feature_1"] highlightedImage:[UIImage imageNamed:@"new_feature_2"]];
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(200, 200, 100, 140)];
    
    NSArray *imageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"new_feature_1"],[UIImage imageNamed:@"new_feature_2"],[UIImage imageNamed:@"new_feature_3"],[UIImage imageNamed:@"new_feature_4"], nil];
    //添加
    [self.view addSubview:imageView];
    [self.view addSubview:imageView2];
    //frame和bounds
    //bounds x y不影响
    imageView.frame = CGRectMake(20, 100, 100, 140);
//    imageView.bounds = CGRectMake(400, 400, 100, 100);
    
    //contentmode
    imageView.backgroundColor = [UIColor redColor];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    //修改center
    imageView.center = CGPointMake(180, 300);
    //位置移动
    imageView.transform = CGAffineTransformMakeTranslation(-30, -30);
    //缩放 在旋转前 CGAffineTransformMakeScale会覆盖上面的transform
    imageView.transform = CGAffineTransformScale(imageView.transform, 0.8, 0.8);
    //旋转
    imageView.transform = CGAffineTransformRotate(imageView.transform ,M_PI*(45)/180.0);
    //允许操作
    imageView.userInteractionEnabled = YES;
    //添加手势
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
    [imageView addGestureRecognizer:singleTap];
    //默认highlight
    imageView.highlighted = YES;
    
    //播放一组图片
    imageView2.animationImages = imageArray;
    // 设定所有的图片在多少秒内播放完毕
    imageView2.animationDuration = [imageArray count];
    // 不重复播放多少遍，0表示无数遍
    imageView2.animationRepeatCount = 0;
    // 开始播放
    [imageView2 startAnimating];
}

- (void)onClickImage {
    if(imageView.highlighted == YES){
        imageView.highlighted = NO;
    }else{
        imageView.highlighted = YES;
    }
}

@end
