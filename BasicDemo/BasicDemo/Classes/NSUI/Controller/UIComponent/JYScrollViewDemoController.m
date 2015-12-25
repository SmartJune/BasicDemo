//
//  JYScrollViewDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/16.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYScrollViewDemoController.h"

#define kImageCount 3

@interface JYScrollViewDemoController ()

// 滚动视图
@property (weak, nonatomic) UIScrollView *scrollView;
// 分页控件
@property (weak, nonatomic) UIPageControl *pageControl;

@end

@implementation JYScrollViewDemoController

- (void)loadView
{
    // 1. 实例化视图
    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    
    // 2. 实例化滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 3. 创建数据，建立一个图像的数组
    // 1) 因为要多添加收尾两张图片，因此需要建立一个kImageCount+2的数组
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:kImageCount + 2];
    
    // 3.2.1 首先将图片依次添加到数组
    for (NSInteger i = 0; i < kImageCount; i++) {
        // 1> 图像名称
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d.jpg", i + 1];
        // 2> 建立图像
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        // 3> 将图像视图添加到数组
        [array addObject:imageView];
    }
    
    // 不能直接使用现有数组中的imageView向数组中继续添加,指针重复导致崩溃，要重新新建一张
    // 将最末一张图片插入到数组的头部
    UIImage *lastImage = [UIImage imageNamed:@"new_feature_3.jpg"];
    UIImageView *lastImageView = [[UIImageView alloc]initWithImage:lastImage];
//    UIImageView *lastImageView = [[UIImageView alloc]initWithImage:array[2]];
    [array insertObject:lastImageView atIndex:0];
    
    // 3.2.3 将第一张图片追加到数组的尾部
    UIImage *firstImage = [UIImage imageNamed:@"new_feature_1.jpg"];
    UIImageView *firstImageView = [[UIImageView alloc]initWithImage:firstImage];
    [array addObject:firstImageView];
    
    NSLog(@"%@", array);
    
    // 4 将数组中的图像视图，添加到scrollView中
    // 记住，现在的图像数组中，多了首、尾两张图片
    CGFloat width = scrollView.bounds.size.width;
    CGFloat height = scrollView.bounds.size.height;
    
    for (NSInteger i = 0; i < kImageCount + 2; i++) {
        UIImageView *imageView = array[i];
        
        // 设置imageView 在滚动视图中的位置和大小
        [imageView setFrame:CGRectMake(i * width, 0, width, height)];
        
        // 将imageView添加到滚动视图
        [scrollView addSubview:imageView];
    }
    
    // 5. 设置滚动视图的属性
    // 1) 允许分页
    [scrollView setPagingEnabled:YES];
    // 2) 禁用弹簧效果
    [scrollView setBounces:NO];
    // 3) 禁用水平滚动条
    [scrollView setShowsHorizontalScrollIndicator:NO];
    // 4) 设置代理
    [scrollView setDelegate:self];
    // 5) 设置内容大小
    [scrollView setContentSize:CGSizeMake((kImageCount + 2) * width, height)];
    // 6）设置contentOffset显示第一张图片
    [scrollView setContentOffset:CGPointMake(width, 0)];
    
    // 6. 分页控件
    // 1) 设置分页控件的位置
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    CGSize size = [pageControl sizeForNumberOfPages:kImageCount];
    [pageControl setFrame:CGRectMake(0, 0, size.width, size.height)];
    [pageControl setCenter:CGPointMake(width / 2, 400)];
    
    // 2) 设置页数
    [pageControl setNumberOfPages:kImageCount];
    // pageControl只关心用户看到的真实页数，而不关心scrollView中的实际是如何处理的
    // pageControl中的页数，比scrollView中的页数少1
    [pageControl setCurrentPage:0];
    // 3) 设置显示标示
    [pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [pageControl setPageIndicatorTintColor:[UIColor blackColor]];
    
    // 4) 将分页控件添加到视图
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    // 5) 增加分页控件的监听事件
    [pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

//点击分页控件
- (void)pageChanged:(UIPageControl *)page
{
    // 根据page的当前页号，重新设置scrollView的偏移
    NSLog(@"要显示的页号 %d", page.currentPage);
    
    // 根据页号计算scrollView的水平偏移位置，注意scrollView中的实际页数比pageControl的页数大1
    CGFloat offsetX = (page.currentPage + 1) * self.scrollView.bounds.size.width;
    
    // 在此设置滚动视图偏移位置时，需要使用动画效果
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

//滚动视图减速事件
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 1. 判断当前所在页面的页数
    NSInteger pageNo = scrollView.contentOffset.x / scrollView.bounds.size.width;
    // 2. 如果是第0页，表示当前在最后一页
    // 3. 如果是第kImageCount + 1页，表示当前在第一页
    if (0 == pageNo || kImageCount + 1 == pageNo) {
        if (0 == pageNo) {
            pageNo = kImageCount;
        } else {
            pageNo = 1;
        }
        
        // 注意不要使用动画属性
        [scrollView setContentOffset:CGPointMake(pageNo * scrollView.bounds.size.width, 0)];
    }
    
    // 4. 设置分页控件的页码
    [self.pageControl setCurrentPage:pageNo - 1];}


@end
