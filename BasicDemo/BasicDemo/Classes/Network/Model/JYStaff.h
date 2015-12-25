//
//  JYStaff.h
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/18.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYStaff : UIView <NSCoding>

@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) int age;
@property (nonatomic,assign) float height;

@end
