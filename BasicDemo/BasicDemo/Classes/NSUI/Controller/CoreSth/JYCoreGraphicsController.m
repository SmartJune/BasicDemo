//
//  JYCoreGraphicsController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/22.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYCoreGraphicsController.h"
#import "JYCoreButton.h"
#import "JYCoreView.h"

@interface JYCoreGraphicsController ()

@end

@implementation JYCoreGraphicsController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //core view
    JYCoreView *coreView = [[JYCoreView alloc]initWithFrame:CGRectMake(0.0, 50.0, 320.0, 536)];
    [self.view addSubview:coreView];
    
    //core button
    NSString *string = @"你好";
    CGSize size= [string sizeWithFont:[UIFont systemFontOfSize:15] forWidth:200 lineBreakMode:NSLineBreakByCharWrapping];
    JYCoreButton *coreButton = [[JYCoreButton alloc]initWithFrame:CGRectMake(20.0, 300.0, size.width +40, size.height +20)];
    coreButton.isFlat = YES;
    coreButton.upColor = [UIColor orangeColor];
    coreButton.downColor = [UIColor redColor];
    [coreButton setTitle:@"你好" forState:UIControlStateNormal];
    [self.view addSubview:coreButton];

}
/*
 获得图形上下文
 CGContextRef ctx = UIGraphicsGetCurrentContext();

 拼接路径（下面代码是搞一条线段）
 CGContextMoveToPoint(ctx, 10, 10);
 CGContextAddLineToPoint(ctx, 100, 100);

 绘制路径
 CGContextStrokePath(ctx); // CGContextFillPath(ctx);
 
 新建一个起点
 void CGContextMoveToPoint(CGContextRef c, CGFloat x, CGFloat y)
 
 添加新的线段到某个点
 void CGContextAddLineToPoint(CGContextRef c, CGFloat x, CGFloat y)
 
 添加一个矩形
 void CGContextAddRect(CGContextRef c, CGRect rect)
 
 添加一个椭圆
 void CGContextAddEllipseInRect(CGContextRef context, CGRect rect)
 
 添加一个圆弧
 void CGContextAddArc(CGContextRef c, CGFloat x, CGFloat y,
 CGFloat radius, CGFloat startAngle, CGFloat endAngle, int clockwise)
 
 Mode参数决定绘制的模式
 void CGContextDrawPath(CGContextRef c, CGPathDrawingMode mode)
 
 绘制空心路径
 void CGContextStrokePath(CGContextRef c)
 
 绘制实心路径
 void CGContextFillPath(CGContextRef c)
 
 将当前的上下文copy一份,保存到栈顶(那个栈叫做”图形上下文栈”)
 void CGContextSaveGState(CGContextRef c)
 
 将栈顶的上下文出栈,替换掉当前的上下文
 void CGContextRestoreGState(CGContextRef c)
 
 改变属性后需要重新绘制
 [self setNeedsDisplay];
 
 提示：一般以CGContextDraw、CGContextStroke、CGContextFill开头的函数，都是用来绘制路径的
*/

@end
