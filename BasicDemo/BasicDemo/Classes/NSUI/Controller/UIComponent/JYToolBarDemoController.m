//
//  JYToolBarDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/17.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYToolBarDemoController.h"

@interface JYToolBarDemoController ()

@end

@implementation JYToolBarDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //创建toolbar
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 420.0f, 320.0f, 40.0f) ];
        
        //创建barbuttonitem1
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStyleBordered target:self action:@selector(test:)];
        
        //创建barbuttonitem2
        UIBarButtonItem *item2;
        item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(test2)];
        
        //创建一个segmentController
        UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"andorid", @"iOS", nil] ];
        
        //设置style
        [seg setSegmentedControlStyle:UISegmentedControlSegmentCenter];
        //绑定方法
        [seg addTarget:self action:@selector(segmentControllerItem:) forControlEvents:UIControlEventValueChanged];
        
        //创建一个内容是view的uibarbuttonitem
        UIBarButtonItem *itemSeg = [[UIBarButtonItem alloc] initWithCustomView:seg];
        
        //创建barbuttonitem,样式是flexible,这个种barbuttonitem用于两个barbuttonitem之间
        //调整两个item之间的距离.flexible表示距离是动态的,fixed表示是固定的
        UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        //把item添加到toolbar里
        [toolBar setItems:[NSArray arrayWithObjects:item1,flexible,itemSeg,flexible,item2, nil] animated:YES];

        //把toolbar添加到view上
        [self.view addSubview:toolBar];
        
    }
    return self;
}

-(void)test:(id)sender
{
    UIBarButtonItem *item = (UIBarButtonItem *) sender;
    NSString *title = [NSString stringWithFormat:@"%@ 被选中了",item.title];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Attention" message:title delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)test2 {

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)segmentControllerItem:(id)sender
{
    UISegmentedControl *seg = (UISegmentedControl *) sender;
    NSInteger index = seg.selectedSegmentIndex;
    NSString *message;
    if (index == 0) {
        message = @"你选了android";
    }
    else
    {
        message = @"你选了iOS";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Attenton" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alertView show];
}
@end
