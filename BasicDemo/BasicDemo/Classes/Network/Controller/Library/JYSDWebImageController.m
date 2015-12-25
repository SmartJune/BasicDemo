//
//  JYSDWebImageController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/21.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYSDWebImageController.h"
#import "JYAPP.h"
#import "UIImageView+WebCache.h"

@interface JYSDWebImageController ()

@end

@implementation JYSDWebImageController

/*
 UIImageView category提供下载网络图片的方法，异步下载，自动缓存，高性能
 */

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self setupCommonDemo];
}

//清除缓存
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[[SDWebImageManager sharedManager] imageCache] clearDisk];
    [[[SDWebImageManager sharedManager] imageCache] clearMemory];
}

- (void)setupCommonDemo {

    NSString *url1 = @"http://p16.qhimg.com/dr/48_48_/t0125e8d438ae9d2fbb.png";
    NSString *url2 = @"http://p19.qhimg.com/dr/48_48_/t0101e2931181bb540d.png";
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [imageView1 sd_setImageWithURL:[NSURL URLWithString:url1] placeholderImage:[UIImage imageNamed:@"avatar_default_big"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                float progress = (float)receivedSize/expectedSize;
                NSLog(@"下载进度 %f", progress);
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                 NSLog(@"%@", [NSThread currentThread]);
            }];

    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(200, 200, 100, 100)];
    [imageView2 sd_setImageWithURL:[NSURL URLWithString:url2] placeholderImage:[UIImage imageNamed:@"avatar_default_big"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        float progress = (float)receivedSize/expectedSize;
        NSLog(@"下载进度 %f", progress);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"%@", [NSThread currentThread]);
    }];

    [self.view addSubview:imageView1];
    [self.view addSubview:imageView2];
    
}

//    下载图像的方法
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:app.icon] placeholderImage:[UIImage imageNamed:@"user_default"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        // receivedSize 已经接受到的大小
//        // expectedSize 期望的大小，总大小
//        float progress = (float)receivedSize/expectedSize;
//        NSLog(@"下载进度 %f", progress);
//        
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        NSLog(@"%@", [NSThread currentThread]);
//    }];


@end
