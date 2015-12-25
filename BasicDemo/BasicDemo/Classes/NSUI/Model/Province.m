//
//  Province.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/17.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "Province.h"

@implementation Province

-(instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+(instancetype)provinceWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

+(NSArray *)provinceList{
    //plist文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"provinces.plist" ofType:nil];
    NSArray *provincePlist = [NSArray arrayWithContentsOfFile:filePath];
    
    NSMutableArray *provinceM = [NSMutableArray array];
    for (NSDictionary *dic in provincePlist) {
        Province *prov = [Province provinceWithDict:dic];
        [provinceM addObject:prov];
    }
    
    return provinceM;
    
}

@end
