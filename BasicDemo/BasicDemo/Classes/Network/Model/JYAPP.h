//
//  JYAPP.h
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/21.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYAPP : NSObject

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *icon;

@property(nonatomic,copy)NSString *download;


+(instancetype)appWithDict:(NSDictionary *)dict;


@end
