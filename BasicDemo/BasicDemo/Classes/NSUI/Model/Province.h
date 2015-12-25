//
//  Province.h
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/17.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Province : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)NSArray *cities;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)provinceWithDict:(NSDictionary *)dict;


+(NSArray *)provinceList;



@end
