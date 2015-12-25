//
//  JYCoreText.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/23.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYCoreText.h"
#import <CoreText/CoreText.h>

@implementation JYCoreText

void RunDelegateDeallocCallback( void* refCon ){
    
}

//图片高度
CGFloat RunDelegateGetAscentCallback( void *refCon ){
    NSString *imageName = (__bridge NSString *)refCon;
    return [UIImage imageNamed:imageName].size.height;
}

CGFloat RunDelegateGetDescentCallback(void *refCon){
    return 0;
}

//图片宽度
CGFloat RunDelegateGetWidthCallback(void *refCon){
    NSString *imageName = (__bridge NSString *)refCon;
    return [UIImage imageNamed:imageName].size.width;
}


- (void)drawRect:(CGRect)rect
{
    //当前context
    CGContextRef contxt = UIGraphicsGetCurrentContext();
    //字形不变换
    CGContextSetTextMatrix(contxt, CGAffineTransformIdentity);
    
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, self.bounds.size.height);
    CGContextConcatCTM(contxt, flipVertical);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:@"步骤:1.设置字形变换矩阵为CGAffineTransformIdentity，也就是说每一个字形都不做图形变换，将当前context的坐标系进行flip，2.为图片设置CTRunDelegate,这个delegate决定留给图片的空间大小。 3.把图片画上去" ];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, [attributedString length])];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0.0, 10)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(10, 20)];
    
    //创建图片位置
    NSString *imageName = @"avatar_default_big";
    CTRunDelegateCallbacks imageCallbacks;
    imageCallbacks.version = kCTRunDelegateVersion1;
    imageCallbacks.dealloc = RunDelegateDeallocCallback;
    imageCallbacks.getAscent = RunDelegateGetAscentCallback;
    imageCallbacks.getDescent = RunDelegateGetDescentCallback;
    imageCallbacks.getWidth = RunDelegateGetWidthCallback;
    
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&imageCallbacks, (__bridge void *)imageName);
    //创建一个空格，来使新的attributedString生效
    NSMutableAttributedString *imageAttributedString =[[NSMutableAttributedString alloc]initWithString:@" "];
    //设置回调
    [imageAttributedString addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)runDelegate range:NSMakeRange(0, 1)];
    CFRelease(runDelegate);
    
    [imageAttributedString addAttribute:@"imageName" value:imageName range:NSMakeRange(0, 1)];
    //把attribute 插入到一个特定的位置
    [attributedString insertAttributedString:imageAttributedString atIndex:8];
    [attributedString insertAttributedString:imageAttributedString atIndex:50];

    //创建图片位置至此完成那个
    
    
    CTFramesetterRef ctFrameSetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef)attributedString);
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect bounds = CGRectMake(0.0, 20.0, self.bounds.size.width, self.bounds.size.height-20);
    CGPathAddRect(path, NULL, bounds);
    
    CTFrameRef ctFrame = CTFramesetterCreateFrame(ctFrameSetter, CFRangeMake(0, 0), path, NULL);
    CTFrameDraw(ctFrame, contxt);
    
    //现在开始画图片
    CFArrayRef lines = CTFrameGetLines(ctFrame);
    CGPoint lineOrigins [CFArrayGetCount(lines)]; //这是一个方法
    CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), lineOrigins);
    
    
    for (int i = 0; i < CFArrayGetCount(lines); i++) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CGFloat lineAscent;
        CGFloat lineDescent;
        CGFloat lineLeading;
        CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, &lineLeading);
        
        CFArrayRef runs = CTLineGetGlyphRuns(line);
        for (int j = 0; j < CFArrayGetCount(runs); j++) {
            CGFloat runAscent;
            CGFloat runDescent;
            CGPoint lineOrigin = lineOrigins[i];
            CTRunRef run = CFArrayGetValueAtIndex(runs, j);
            NSDictionary* attributes = (NSDictionary*)CTRunGetAttributes(run);
            CGRect runRect;
            runRect.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0,0), &runAscent, &runDescent, NULL);
            
            runRect=CGRectMake(lineOrigin.x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL), lineOrigin.y - runDescent, runRect.size.width, runAscent + runDescent);
            
            NSString *imageName = [attributes objectForKey:@"imageName"];
            //图片渲染逻辑
            if (imageName)
            {
                UIImage *image = [UIImage imageNamed:imageName];
                if (image)
                {
                    CGRect imageDrawRect;
                    imageDrawRect.size = image.size;
                    imageDrawRect.origin.x = runRect.origin.x + lineOrigin.x;
                    imageDrawRect.origin.y = lineOrigin.y +lineDescent+10;// 怎么精确计算
                    CGContextDrawImage(contxt, imageDrawRect, image.CGImage);
                }
            }
        }
    }
    
    
    
    //画图片结束
    
    CFRelease(ctFrame);
    CFRelease(path);
    CFRelease(ctFrameSetter);
}



@end
