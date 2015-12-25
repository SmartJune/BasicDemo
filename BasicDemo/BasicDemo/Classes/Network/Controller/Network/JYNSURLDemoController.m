//
//  JYNSURLDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/18.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYNSURLDemoController.h"

@interface JYNSURLDemoController ()

@end

@implementation JYNSURLDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self NSURLDelegateDemo];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self syncNetwork];
//    [self asyncNetwork];
    [self NSURLDelegateDemo];
}

//代理测试
- (void)NSURLDelegateDemo {
    //来个文件下载地址
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://lotus.sp.iqiyi.com/ota?id=&pubplatform=6&pubarea=pcltdown_15030501&qipuid=&u=&pu="] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
    theConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if (theConnection) {
        receivedData = [NSMutableData data];
    }else{
        NSLog(@"失败");
    }
    
}

//数据下载完毕
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"%lu",(unsigned long)receivedData.length);
    NSString *dataString = [[NSString alloc]initWithData:receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"download succeed：%@",dataString);
    //连接完顺便置空
    theConnection = nil;
    [receivedData setLength:0];
}

//连接失败之后，不会再接受任何消息
- (void)connection:(NSURLConnection *)connection didFailWithError:(nonnull NSError *)error
{
    theConnection = nil;
    NSLog(@"连接失败 %@, %@",[error description], [[error userInfo] objectForKey:NSURLErrorFailingURLErrorKey]);
}

//服务器返回了可以创建response对象的信息之后调用，一般在此检查服务器提供的元信息，mime type 文件名什么的
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
    //服务器重置之类的时候也会收到该消息，所以这里丢弃掉之前的数据
}

//下载开始之后接受到数据，一般在此储存新接收的消息
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
    NSLog(@"在下载");
}

- (void)syncNetwork {
    // 1. url
    NSURL *url = [NSURL URLWithString:@"http://www.google.com.hk"];
    
    // 2. 建立请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:2];
    
    // 3. 建立连接Connection， 发送同步请求到服务器
    /**
     SynchronousRequest发送同步请求
     returningResponse: 服务器响应的地址
     error: 错误信息的地址
     */
    
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    
    NSLog(@"%@...%@---response%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding], [NSThread currentThread], response);
    // 解压缩
    NSLog(@"解压缩222---%@", [NSThread currentThread]);
    
}

- (void)asyncNetwork {

    //    这个方法是同步的。 同步方法超时时长60秒
    //    NSData *data = [NSData dataWithContentsOfURL:url];
    //    UIImage *image = [UIImage imageWithData:data];
    
    // 1. url
    NSURL *url = [NSURL URLWithString:@"http://www.google.com.hk"];
    // 2. 建立请求
    /*
     cachePolicy：0会自动缓存，1每次都从服务器去加载数据。忽略本地缓存
     wifi用2：NSURLRequestReturnCacheDataElseLoad 如果有缓存，就用缓存。没有就上网加载
     3G用3:NSURLRequestReturnCacheDataDontLoad 如有缓存，就用缓存。没有返回空，死活不上网
     timeoutInterval：超时时间，默认是60秒
     */
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:2];
    
    // 3. 建立连接Connection， 发送请求到服务器
    /**
     queue: 队列，这个队列，是完成以后，回调block执行的队列、
     Asynchronous：只要是异步，肯定会开新的线程
     // 使用场景：如果下载的是压缩包，解压缩也是耗时操作。也需要放在子线程
     // 如果回调block里面只需要更新UI，那么就可以只开始指定queue为主队列
     Handler：网络访问完成以后执行的代码块
     response: 服务器的响应（包含响应行/响应头...下载的时候才去关心这个）
     data： 返回的二进制数据
     connectionError：在连接服务器的时候的错误，只要是能正常连接到服务器，就不会有错。
     只要有网络候出现的错访问，就会可能有错误
     */
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError || data == nil) {
            NSLog(@"%@----您的网络不给力，请稍后再试", connectionError);
            return;
        }
        // 解压缩
        NSLog(@"解压缩111---%@", [NSThread currentThread]);
        // 更新UI在主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            // 网络请求完成以后调用的这块代码，从服务器获得二进制数据
            NSLog(@"更新UI%@---%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding], [NSThread currentThread]);
        });
    }];

}

@end
