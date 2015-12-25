//
//  UIBarButtonItem+item.h
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/15.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (item)

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;


@end
