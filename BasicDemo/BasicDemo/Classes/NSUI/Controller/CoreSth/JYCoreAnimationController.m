//
//  JYCoreAnimationControllerViewController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/22.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYCoreAnimationController.h"
#import "Fireworks.h"

@interface JYCoreAnimationController ()

@end

@implementation JYCoreAnimationController

//CAAnimation可分为四种：
//
//CABasicAnimation
//通过设定起始点，终点，时间，动画会沿着你这设定点进行移动。可以看做特殊的CAKeyFrameAnimation
//CAKeyframeAnimation
//Keyframe顾名思义就是关键点的frame，你可以通过设定CALayer的始点、中间关键点、终点的frame，时间，动画会沿你设定的轨迹进行移动
//CAAnimationGroup
//Group也就是组合的意思，就是把对这个Layer的所有动画都组合起来。PS：一个layer设定了很多动画，他们都会同时执行
//CATransition
//这个就是苹果帮开发者封装好的一些动画

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initButtons];
    }

//初始化按钮们
- (void)initButtons
{
    NSArray *names = [[NSArray alloc]initWithObjects:@"变色",@"block变色",
                      @"BasAnimal",@"KeyFrame变色",@"KeyFrame位移",@"Group",@"3DTransform",@"CAEmitter", nil];
    
    int numbsersInRow = 3;
    int height = 30;
    int startY = self.view.bounds.size.height - height*([names count]/numbsersInRow+1);
    
    
    for (int i =0; i<[names count]; i++) {
        
        int xPoz = i %numbsersInRow;
        int yPoz = i /numbsersInRow;
        UIButton *abtn = [[UIButton alloc]initWithFrame:CGRectMake(1+xPoz*320/numbsersInRow, startY + yPoz*height, 320/numbsersInRow-1, height-2)];
        //区分
        abtn.tag = i;
        [abtn setTitle:(NSString *)[names objectAtIndex:i] forState:UIControlStateNormal];
        [abtn setBackgroundColor:[UIColor grayColor]];
        [abtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        abtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [abtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:abtn];
    }
}

-(void)clickBtn:(UIButton *)sender
{
    //恢复原始状态
    for (UIView *aView in [self.view subviews]) {
        if (![aView isKindOfClass:[UIButton class]]) {
            [aView removeFromSuperview];
        }
    }
    switch (sender.tag) {
        case 0:
            [self doUIKitAnimationMethod1];
            break;
        case 1:
            [self doUIKitAnimationMethod2];
            break;
        case 2:
            [self doCALayerBasicAnimation];
            break;
        case 3:
            [self doCALayerKeyFrameAnimation];
            break;
        case 4:
            [self doCALayerKeyFremAnimationMethod2];
            break;
        case 5:
            [self doBase3DtransformGroupAnimation];
            break;
        case 6:
            [self do3DtransformAnimation];
            break;
        case 7:
            [self CAEmitter];
            break;
        default:
            break;
    }
}

//位移 变色 测试1
-(void)doUIKitAnimationMethod1
{
    UIView *box = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 50.0, 50.0)];
    box.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:box];
    
    [UIView beginAnimations:@"box-animation" context:nil];
    [UIView setAnimationDuration:1];
    
    box.backgroundColor = [UIColor redColor];
    box.frame = CGRectMake(50.0, 50.0, 100, 100);
    box.alpha = 0.5;
    
    [UIView commitAnimations];
}

//block写法 测试2
-(void)doUIKitAnimationMethod2
{
    UIView *box = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 50.0, 50.0)];
    box.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:box];
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        box.backgroundColor = [UIColor redColor];
        box.frame = CGRectMake(50.0, 50.0, 100, 100);
        box.alpha = 0.5;
    } completion:^(BOOL finished) {
        NSLog(@"finished");
    }];
}

//BasicAnimation
-(void)doCALayerBasicAnimation
{
    UIView *box = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 100.0, 100.0)];
    box.backgroundColor = [UIColor blueColor];
    [self.view addSubview:box];
    
    //变色
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.toValue = (id)[UIColor yellowColor].CGColor;
    animation.duration = 1;
    //结束时是否执行逆动画
    animation.autoreverses = YES;
    [box.layer addAnimation:animation forKey:@"backgroundColor"];
    
    //移动
    CATransition *trans = [CATransition animation];
    trans.type = kCATransitionReveal;
    trans.subtype = kCATransitionFromLeft;
    trans.duration = 0.5;
    [self.view.layer addAnimation:trans forKey:@"transition"];
    box.layer.backgroundColor = [UIColor redColor].CGColor;
}

//KeyFrameAnimation 变色测试
-(void)doCALayerKeyFrameAnimation
{
    UIView *box = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 100.0, 100.0)];
    box.backgroundColor = [UIColor blueColor];
    [self.view addSubview:box];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.values = [NSArray arrayWithObjects:
                        (id)box.layer.backgroundColor,
                        (id)[UIColor yellowColor].CGColor,
                        (id)[UIColor greenColor].CGColor,
                        (id)[UIColor blueColor].CGColor,nil];
    animation.duration =3;
    animation.autoreverses = NO;
    [box.layer addAnimation:animation forKey:@"backgroundColor"];
}

//KeyFrameAnimation 位移测试
-(void)doCALayerKeyFremAnimationMethod2
{
    UIView *box = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 50.0, 50.0)];
    box.backgroundColor = [UIColor blueColor];
    [self.view addSubview:box];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    CGMutablePathRef aPath = CGPathCreateMutable();
    CGPathMoveToPoint(aPath, nil, 10, 10);
    CGPathAddCurveToPoint(aPath, nil, 160, 30, 220, 220, 240, 380);
    
    
    animation.path = aPath;
    animation.duration = 1;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.rotationMode = @"auto";
    [box.layer addAnimation:animation forKey:@"position"];
    box.layer.position = CGPointMake(240, 380);
    
    CFRelease(aPath);
}

//AnimationGroup 测试
-(void)doBase3DtransformGroupAnimation
{
    CABasicAnimation *flip = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    flip.toValue = [NSNumber numberWithDouble:-M_PI];
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.toValue = [NSNumber numberWithDouble:.3];
    scale.duration = 0.5;
    scale.autoreverses = YES;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:flip,scale, nil];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    group.duration = 1;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    UIView *box = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 100.0, 100.0)];
    box.backgroundColor = [UIColor blueColor];
    [self.view addSubview:box];
    
    [box.layer addAnimation:group forKey:@"flip"];
}

/*
 transform的结构如下：
 struct CATransform3D
 {
    CGFloat m11, m12, m13, m14;
    CGFloat m21, m22, m23, m24;
    CGFloat m31, m32, m33, m34;
    CGFloat m41, m42, m43, m44;
 };
 首先要实现view（layer）的透视效果（就是近大远小），是通过设置m34的：
 CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
 rotationAndPerspectiveTransform.m34 = 1.0 / -500;
 m34负责z轴方向的translation（移动），m34= -1/D,  默认值是0，也就是说D无穷大，这意味layer in projection plane（投射面）和layer in world coordinate重合了
 D越小透视效果越明显。
*/
-(void)do3DtransformAnimation
{
    UIView *box = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 100.0, 100.0)];
    box.backgroundColor = [UIColor blueColor];
    [self.view addSubview:box];
    
    box.layer.anchorPoint = CGPointMake(1, 0.5);
    CABasicAnimation *flip = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    flip.toValue = [NSNumber numberWithDouble:M_PI];
    flip.duration = 1.5;
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0/1000;
    perspective = CATransform3DRotate(perspective, M_PI/3, 0, 1, 0);
    box.layer.transform = perspective;
    [box.layer addAnimation:flip forKey:@"flip"];
}

//网上的烟花成品Demo
//CAEmitter粒子效果
-(void)CAEmitter
{
    Fireworks *fireworks = [[Fireworks alloc] initWithFrame:self.view.bounds];
    fireworks.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
    fireworks.backgroundColor = [UIColor blackColor];
    [self.view addSubview:fireworks];
    
    [fireworks launchFirework];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fireworksTapped:)];
    [fireworks addGestureRecognizer:tap];
}

- (void)fireworksTapped:(UITapGestureRecognizer*)tap
{
    for (UIView *aView in [self.view subviews]) {
        if (![aView isKindOfClass:[UIButton class]]) {
            [aView removeFromSuperview];
        }
    }
    
}


@end
