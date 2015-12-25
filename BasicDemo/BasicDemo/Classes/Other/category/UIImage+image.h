//
//  UIImage+image.h
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/15.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (image)

// 加载没渲染过的图片
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

/**
 *  根据图片名自动加载适配iOS6\7的图片
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  根据图片名返回一张能够自由拉伸的图片
 */
+ (UIImage *)resizedImage:(NSString *)name;

@end
