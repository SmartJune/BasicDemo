//
//  Message.h
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/16.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

+ (id)messageWithContent:(NSString *)content fromSelf:(BOOL)fromSelf;

@property (strong, nonatomic) NSString *content;
@property (assign, nonatomic) BOOL fromSelf;

@end
