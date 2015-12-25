//
//  JYURLSessionDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/18.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYURLSessionDemoController.h"

@interface JYURLSessionDemoController ()

/**下载任务*/
@property(nonatomic,strong)NSURLSessionDownloadTask *downloadTask;

/**全局管理的会话*/
@property(nonatomic,strong)NSURLSession *session;

/**续传的数据*/
@property(nonatomic,strong)NSData *resumeData;

@end

@implementation JYURLSessionDemoController

bool begin = false;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self start];
}

//视图将要消失的时候，取消session.避免强引用
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 任务完成，取消NSURLSession
    [self.session invalidateAndCancel];
    // 释放会话
    self.session = nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (begin == false) {
        [self pause];
//        begin = !begin;
    }else{
        [self resume];
    }
    begin = !begin;
}

- (NSURLSession *)session
{
    if (_session == nil) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    }
    return _session;
}

//继续
- (void)resume
{
    if (self.resumeData == nil) {
        NSLog(@"没有续传的数据");
    }
    
    // 使用上一次的记录，新建一个下载任务
    self.downloadTask =  [self.session downloadTaskWithResumeData:self.resumeData];
    // 一旦任务建立完成，之前的续传数据没有用，释放掉
    self.resumeData = nil;
    [self.downloadTask resume];
}

//暂停
- (void)pause
{
    NSLog(@"%s", __func__);
    
    [self.downloadTask cancelByProducingResumeData:^(NSData *resumeData) {
        
        NSLog(@"＝----%tu", resumeData.length);
        
        // 保存起来暂停的时候的字节数
        self.resumeData = resumeData;
        
        // 释放下载任务
        self.downloadTask = nil;
    }];
}

//开始
- (void)start {
    // 1. url
    NSString *urlStr = @"http://lotus.sp.iqiyi.com/ota?id=&pubplatform=6&pubarea=pcltdown_15030501&qipuid=&u=&pu=";
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 2. 通过session对象 开始一个任务
    self.downloadTask = [self.session downloadTaskWithURL:url];
    
    // 继续
    [self.downloadTask resume];
}

// 1. 下载完成被调用的方法  iOS 7 & iOS 8都必须实现
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSLog(@"下载完成..");
    self.downloadTask = nil;
}

// 2. 下载进度变化的时候被调用的
// bytesWritten：     本次写入的字节数
// totalBytesWritten：已经写入的字节数（目前下载的字节数）
// totalBytesExpectedToWrite： 总的下载字节数(文件的总大小)
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    float progress = (float)totalBytesWritten / totalBytesExpectedToWrite;
    NSLog(@"%f---%@", progress, [NSThread currentThread]);
}

// 3. 断点续传的时候，被调用的。一般什么都不用写 iOS 8可以不实现
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    
}



@end
