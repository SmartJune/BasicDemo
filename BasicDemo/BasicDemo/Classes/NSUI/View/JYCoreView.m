//
//  JYCoreView.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/22.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYCoreView.h"
#import "CoreGraphicTools.h"

@implementation JYCoreView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //上下文的画笔颜色 为何改了之后1 2没变？
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    
    //画线
    NSString *str1 = @"画线";
    [self drawText:str1 atPoint:CGPointMake(20.0, 20.0) FontSize:15];
    [self drawLineOnContext:context FromPoint:CGPointMake(20.0, 40.0)  toPoint:CGPointMake(300.0, 40.0)];
    
    //画多边形
    NSString *str2 = @"画多边形";
    [self drawText:str2 atPoint:CGPointMake(20.0, 50.0) FontSize:15];
    UIBezierPath *btnPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20.0, 70.0, 280.0, 50) cornerRadius:4];
    do {
        CGContextSaveGState(context);
        //CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextSetShadowWithColor(context, CGSizeMake(-1, -1), 3.0, [UIColor whiteColor].CGColor);
        CGContextAddPath(context, btnPath.CGPath);
        CGContextFillPath(context);
        CGContextRestoreGState(context);
    } while (0);
    //设置阴影
    CGContextSetShadow(context, CGSizeMake(2, 2), 10);
    //添加高亮效果
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    //开始描边
    [[UIColor blackColor]setStroke];
    //[btnPath stroke];
    //开始填充颜色
    [btnPath fill];
    
    //画椭圆，渐变色
    NSString *str3 = @"渐变填充颜色";
    //去除阴影
    CGContextSetShadow(context, CGSizeMake(0, 0), 0);
    [self drawText:str3 atPoint:CGPointMake(20.0, 130.0) FontSize:15];
    CGContextSaveGState(context);
    CGRect newRect = CGRectMake(40.0, 150, 240, 50);
    UIBezierPath *newPath = [UIBezierPath bezierPathWithOvalInRect:newRect];
    //CGContextAddRect(context, newRect);
    [newPath addClip];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSArray *colors = @[(__bridge id)[UIColor colorWithRed:0.3 green:0.0 blue:0.0 alpha:0.2].CGColor,
                        (__bridge id)[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.8].CGColor];
    const CGFloat locations[] = {0.0, 1.0};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(40.0, 150.0), CGPointMake(280.0, 200.0), 0);
    
    CGContextRestoreGState(context);
    
//    
//    NSString *str4 = @"当前形变矩阵CTM";
//    [self drawText:str4 atPoint:CGPointMake(20.0, 220.0) FontSize:15];
//    
//    CGContextTranslateCTM(context, 0, rect.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    // http://www.cnblogs.com/delonchen/archive/2011/08/03/iostransform.html
    
    CFRelease(colorSpace);
    CFRelease(gradient);
}

- (void)drawText:(NSString *)str atPoint:(CGPoint)point FontSize:(float)fontSize
{
    [[UIColor blackColor] set];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:fontSize]};
    [str drawAtPoint:point withAttributes:attributes];
}

-(void)drawLineOnContext:(CGContextRef)context FromPoint:(CGPoint)point1 toPoint:(CGPoint)point2
{
    [[UIColor blackColor] set];
    CGContextSetLineWidth(context, 2.0);
    CGContextMoveToPoint(context, point1.x, point1.y);
    CGContextAddLineToPoint(context, point2.x, point2.y);
    CGContextStrokePath(context);
}


@end
