//
//  JYHeader.h
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/15.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JYHeader;

#define kHeaderHeight 44

#pragma mark - 定义协议
@protocol JYHeaderDelegate <NSObject>

- (void)myHeaderDidSelectedHeader:(JYHeader *)header;

@end

#pragma mark - 定义接口
@interface JYHeader : UITableViewHeaderFooterView

// 定义代理
@property (weak, nonatomic) id <JYHeaderDelegate> delegate;

// 标题栏按钮
@property (weak, nonatomic) UIButton *button;
// 标题栏分组
@property (assign, nonatomic) NSInteger section;

// 是否展开折叠标记
@property (assign, nonatomic) BOOL isOpen;

@end
