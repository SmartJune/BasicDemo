//
//  JYAPP.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/21.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYAPP.h"

@implementation JYAPP

+(instancetype)appWithDict:(NSDictionary *)dict
{
    JYAPP *app = [[self alloc] init];
    
    [app setValuesForKeysWithDictionary:dict];
    
    return app;
}


@end
