//
//  JYTextFieldDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/15.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYTextFieldDemoController.h"

@interface JYTextFieldDemoController ()

@property UITextField* text;

@end

@implementation JYTextFieldDemoController

@synthesize text;
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupCommonTextField];
    
}

- (void)setupCommonTextField {

    //初始化textfield并设置位置及大小
    text = [[UITextField alloc]initWithFrame:CGRectMake(30, 100, 130, 30)];
    [self.view addSubview:text];
    //设置边框样式，只有设置了才会显示边框样式
    text.borderStyle = UITextBorderStyleRoundedRect;
    //设置输入框的背景颜色，此时设置为白色如果使用了自定义的背景图片边框会被忽略掉
    text.backgroundColor = [UIColor whiteColor];
    //设置背景
    text.background = [UIImage imageNamed:@"popover_background"];
    //设置不可用时的背景
    text.disabledBackground = [UIImage imageNamed:@"tabbar_discover_selected"];
    //占位文本
    text.placeholder = @"password";
    //设置输入框内容的字体样式和大小
    text.font = [UIFont fontWithName:@"Arial" size:20.0f];
    //设置字体颜色
    text.textColor = [UIColor redColor];
    //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
    text.clearButtonMode = UITextFieldViewModeAlways;
    //输入框中一开始就有的文字
    text.text = @"12345678";
    //每输入一个字符就变成点用语密码输入
    text.secureTextEntry = YES;
    //是否纠错
    text.autocorrectionType = UITextAutocorrectionTypeNo;
    //再次编辑就清空
    text.clearsOnBeginEditing = YES;
    //内容对齐方式
    text.textAlignment = UITextAlignmentLeft;
    //内容的垂直对齐方式  UITextField继承自UIControl,此类中有一个属性contentVerticalAlignment
    text.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //设置为YES时文本会自动缩小以适应文本窗口大小.默认是保持原来大小,而让长文本滚动
    text.adjustsFontSizeToFitWidth = YES;
    //设置自动缩小显示的最小字体大小
    text.minimumFontSize = 20;
    //设置键盘的样式
    text.keyboardType = UIKeyboardTypeNumberPad;
    //首字母是否大写
    text.autocapitalizationType = UITextAutocapitalizationTypeNone;
    //return键变成什么键
    text.returnKeyType =UIReturnKeyDone;
    //键盘外观
    text.keyboardAppearance=UIKeyboardAppearanceDefault;
    //最左侧加图片
    UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
    text.leftView=image;
    text.leftViewMode = UITextFieldViewModeAlways;
    //代理
    text.delegate = self;
    
}

// 按return回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

//返回一个BOOL值，指定是否循序文本字段开始编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //开始编辑时触发
}

//返回BOOL值，指定是否允许文本字段结束编辑，当编辑结束，文本字段会让出first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    //要想在用户结束编辑时阻止文本字段消失，可以返回NO
    return YES;
}

//当用户使用自动更正功能，把输入的文字修改为推荐的文字时，就会调用这个方法。
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //可以跟踪字段内所做的最后一次修改，也可以对所有编辑做日志记录,用作审计用途。
    //要防止文字被改变可以返回NO
    //这个方法的参数中有一个NSRange对象，指明了被改变文字的位置，建议修改的文本也在其中
    return YES;
}

//返回一个BOOL值指明是否允许根据用户请求清除内容
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    //可以设置在特定条件下才允许清除内容
    return YES;
}

@end
