//
//  ChatCell.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/16.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "ChatCell.h"

@interface ChatCell()

// 用户头像
@property (weak, nonatomic) UIImageView *iconImage;
// 消息按钮
@property (weak, nonatomic) UIButton *msgButton;

@end

@implementation ChatCell

/**
 在聊天布局表格行中包含的内容包括：
 
 1) 用户头像(UIImageView)
 2) 聊天内容(UIButton)
 1> UIButton有背景图片，刚好适合设置聊天内容的背景
 2> UIButton有title，刚好设置聊天的内容文字
 
 条件预设：
 1） 当发言人是“我”，用户头像显示在界面的右侧，消息按钮紧贴着用户头像，间距10个点
 2） 当发言人是“对方”,用户头像显示在界面的左侧，消息按钮紧贴着用户头像，间距10个点
 
 如果使用storyboard或者xib的方式，initWithStyle方法不会被调用。
 此时可以使用awakeFromNib方法来替代。
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        // 单元格的初始化代码
        /**
         在初始化单元格时，并不能确定消息的发送方，因此无法准确的定位头像以及按钮的大小及位置。
         
         按钮的大小需要随发送的文本自动调整
         */
        // 1) 用户头像 60* 60大小
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        [self.contentView addSubview:imageView];
        self.iconImage = imageView;
        
        // 2) 聊天内容按钮
        UIButton *messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:messageButton];
        // 不限制文本行数
        [messageButton.titleLabel setNumberOfLines:0];
        [messageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.msgButton = messageButton;
    }
    
    return self;
}

#pragma mark - 设置聊天内容
- (void)setMessage:(Message *)message
{
    // 1）设置头像的位置
    if (message.fromSelf) {
        [self.iconImage setFrame:CGRectMake(250, 10, 60, 60)];
        [self.iconImage setImage:[UIImage imageNamed:@"avatar_vip"]];
    } else {
        [self.iconImage setFrame:CGRectMake(10, 10, 60, 60)];
        [self.iconImage setImage:[UIImage imageNamed:@"avatar_enterprise_vip"]];
    }
    
    // 2) 设置文字按钮的文本
    CGSize size = [message.content sizeWithFont:[UIFont systemFontOfSize:18]
                              constrainedToSize:CGSizeMake(180, 10000)];
    NSLog(@"%@ %@", NSStringFromCGSize(size), message.content);
    
    // 3) 设置文字按钮的大小和位置
    CGFloat x = 0;
    if (message.fromSelf) {
        x = 250 - 10 - size.width - 40;
    } else {
        x = 80;
    }
    // 增加消息按钮文字的外间距
    [self.msgButton setContentEdgeInsets:UIEdgeInsetsMake(10, 20, 10, 20)];
    [self.msgButton setFrame:CGRectMake(x, 10, size.width + 40, size.height + 20)];
    [self.msgButton setTitle:message.content forState:UIControlStateNormal];
    
    // 4) 设置文字按钮的背景
    UIImage *normalImage;
    UIImage *highImage;
    if (message.fromSelf) {
        normalImage = [UIImage imageNamed:@"chatto_bg_normal.png"];
        highImage = [UIImage imageNamed:@"chatto_bg_focused.png"];
    } else {
        normalImage = [UIImage imageNamed:@"chatfrom_bg_normal.png"];
        highImage = [UIImage imageNamed:@"chatfrom_bg_focused.png"];
    }
    // 拉伸图像
    normalImage = [normalImage stretchableImageWithLeftCapWidth:normalImage.size.width * 0.5 topCapHeight:normalImage.size.height * 0.6];
    highImage = [highImage stretchableImageWithLeftCapWidth:highImage.size.width * 0.5 topCapHeight:highImage.size.height * 0.6];
    
    [self.msgButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    [self.msgButton setBackgroundImage:highImage forState:UIControlStateHighlighted];
}

@end
