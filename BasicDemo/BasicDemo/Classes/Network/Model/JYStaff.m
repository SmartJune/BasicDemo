//
//  JYStaff.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/18.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYStaff.h"

@implementation JYStaff

//NSCoding需要实现的两个方法
- (void)encodeWithCoder:(NSCoder *)aCoder {

    [super encodeWithCoder:aCoder];
    [aCoder encodeInt:self.age forKey:@"age"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeFloat:self.height forKey:@"height"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    self.age = [aDecoder decodeIntForKey:@"age"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.height = [aDecoder decodeFloatForKey:@"height"];
    
    return self;
}


@end
