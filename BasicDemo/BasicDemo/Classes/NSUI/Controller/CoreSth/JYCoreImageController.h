//
//  JYCoreImageController.h
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/23.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYBasicController.h"

@interface JYCoreImageController : JYBasicController

@property (nonatomic,strong) UIImageView *myImageView;
@property (nonatomic,strong) UIImage *originalImage;
@property (nonatomic,strong) CIContext *imageContext;


@end
