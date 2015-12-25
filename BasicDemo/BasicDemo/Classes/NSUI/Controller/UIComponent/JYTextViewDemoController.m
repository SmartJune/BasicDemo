//
//  JYTextViewDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/16.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYTextViewDemoController.h"

@interface JYTextViewDemoController ()

@end

@implementation JYTextViewDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCommonTextView];
}

- (void)setupCommonTextView {
    //初始化大小
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.frame];
    //设置textview里面的字体颜色
    textView.textColor = [UIColor blackColor];
    //设置字体名字和字体大小
    textView.font = [UIFont fontWithName:@"Arial" size:18.0];
    //设置它的委托方法
    textView.delegate = self;
    //设置它的背景颜色
    textView.backgroundColor = [UIColor whiteColor];
    //设置它显示的内容
    textView.text = @"Now is the time for all good developers tocome to serve their country.\n\nNow is the time for all good developers to cometo serve their country.";
    //返回键的类型
    textView.returnKeyType = UIReturnKeyDefault;
    //键盘类型
    textView.keyboardType = UIKeyboardTypeDefault;
    //是否可以拖动
    textView.scrollEnabled = YES;
    //自适应高度
    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    //是否允许编辑内容，默认为“YES”
    textView.editable = YES;
    //当文字超过视图的边框时是否允许滑动，默认为“YES”
    textView.scrollEnabled = NO;
    //文本对齐方式
    textView.textAlignment = NSTextAlignmentLeft;
    //电话号码、网址之类的连接
    textView.dataDetectorTypes = UIDataDetectorTypeAll;
    //添加
    [self.view addSubview:textView];
    
}

//自适应输入本文
- (void)textViewDidChange:(UITextView *)textView{
    //计算文本的高度
    CGSize constraintSize;
    constraintSize.width = textView.frame.size.width-16;
    constraintSize.height = MAXFLOAT;
    CGSize sizeFrame =[textView.text sizeWithFont:textView.font
                                constrainedToSize:constraintSize
                                    lineBreakMode:UILineBreakModeWordWrap];
    
    //重新调整textView的高度
    textView.frame = CGRectMake(textView.frame.origin.x,textView.frame.origin.y,textView.frame.size.width,sizeFrame.height+5);
}

//控制输入的文本
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location>=100)
    {
        //控制输入文本的长度
        return  NO;
    }
    if ([text isEqualToString:@"\n"]) {
        //禁止输入换行
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
