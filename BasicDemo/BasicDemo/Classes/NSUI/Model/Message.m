//
//  Message.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/16.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "Message.h"

@implementation Message


+ (id)messageWithContent:(NSString *)content fromSelf:(BOOL)fromSelf
{
    Message *m = [[Message alloc]init];
    
    [m setContent:content];
    [m setFromSelf:fromSelf];
    
    return m;
}

@end
