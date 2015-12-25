//
//  JYSingletonController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/23.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYSingletonController.h"
#import "June.h"

@implementation JYSingletonController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

//    June *june = [June sharedJune];
    June *june = [[June alloc]init];
    June *june2 = [[June alloc]init];
    June *june3 = [[June alloc]init];
    
    if([june isEqual:june2]&&[june2 isEqual:june3]&&[june3 isEqual:june]){
        NSLog(@"singleton succeed");
    }else{
        NSLog(@"failed");
    }
}

@end
