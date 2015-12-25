//
//  JYHeader.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/15.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYHeader.h"

@implementation JYHeader

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setFrame:CGRectMake(0, 0, 320, kHeaderHeight)];
        
        // 增加按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        NSLog(@"实例化标题行 %@", NSStringFromCGRect(self.bounds));
        
        [button setFrame:self.bounds];
        
        // 设置按钮的图片
        UIImage *image = [UIImage imageNamed:@"disclosure.png"];
        [button setImage:image forState:UIControlStateNormal];
        
        // 设置按钮内容的显示位置
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        
        // 给按钮添加监听事件
        [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:button];
        
        self.button = button;
    }
    
    return self;
}

- (void)clickButton
{
    //点击
    NSLog(@"按钮");
    
    // 通知代理执行协议方法
    [self.delegate myHeaderDidSelectedHeader:self];
}

#pragma mark 展开折叠的setter方法
- (void)setIsOpen:(BOOL)isOpen
{
    _isOpen = isOpen;
    
    // 旋转按钮
    CGFloat angle = isOpen ? M_PI_2 : 0;
    
    [UIView animateWithDuration:0.5f animations:^{
        [self.button.imageView setTransform:CGAffineTransformMakeRotation(angle)];
    }];
}


@end
