//
//  JYAFNDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/21.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYAFNDemoController.h"
#import "AFNetworking.h"

@interface JYAFNDemoController ()

@property(nonatomic,strong)AFHTTPSessionManager *manager;

@end

@implementation JYAFNDemoController

/*
 基于NUSURLConnection的网络访问的封装
 针对JSON XML PList UIImageView都做了封装
 */

/*
 //请求的数据格式，发送给服务器的格式
 self.requestSerializer = [AFHTTPRequestSerializer serializer];
 AFHTTPRequestSerializer  二进制的数据(默认的)
 AFJSONRequestSerializer  JSON
 AFPropertyListRequestSerializer  PList
 
 //响应的解析器(默认直接解析JSON)
 self.responseSerializer = [AFJSONResponseSerializer serializer];
 AFHTTPResponseSerializer   二进制
 AFJSONResponseSerializer   JSON(默认)
 AFXMLParserResponseSerializer  XML
 AFImageResponseSerializer  Image
 */

//session
- (void)sessionTest
{
    NSString *urlStr = @"http://127.0.0.1/videos.json";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self getDemo];
    [self getLogin];
    [self getLogin2];
    [self getXML];
    [self postLogin];
    [self postUpLoad];
    [self postUpLoad];
    
}

//POST上传图片
- (void)postUpLoad
{
    // url
    NSString *urlStr = @"http://127.0.0.1/post/upload.php";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 要上传的图片的路径
        NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"apps.plist" withExtension:nil];
        /**
         FileURL:要上传的文件的url
         name: 上传到服务器，接受这个图片的字段名
         fileName ：  这个文件在服务器的名称
         mimeType: 表示要上传的文件的类型
         格式： 大类/小类
         */
        [formData appendPartWithFileURL:fileUrl name:@"userfile" fileName:@"apps.plist" mimeType:@"pplication/xml" error:NULL];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure");
    }];
}

//XML的解析
- (void)getXML
{
    NSString *urlStr = @"http://127.0.0.1/videos.xml";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 指定我们的响应的解析器是解析XML （会返回NSXMLParser:对象）也就是需要SAX方式手动解析
    //    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    // 假如想使用DOM进行解析XML，可以指定响应的类型是二进制。拿到二进制数据就可以进行DOM解析
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // GET方法
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 已经把反序列化完成的结果都直接返回了。可以更新UI了
        NSLog(@"%@  %@", responseObject, [NSThread currentThread]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

//POST:传递参数以字典的形式传递.

//post登录
- (void)postLogin
{
    NSString *urlStr = @"http://127.0.0.1/login.php";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{@"password" : @"jjjuuunnneee", @"username" : @"june"};
    // POST方法
    [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@  %@", responseObject, [NSThread currentThread]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

//get:网络请求是异步,完成以后的回调代码快直接是在主线程,已经实现了反序列化

//get登录，api增加参数
- (void)getLogin2
{
    NSString *urlStr = @"http://127.0.0.1/login.php";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{@"password" : @"jjjuuunnneee", @"username" : @"june"};
    // GET方法
    [manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@  %@", responseObject, [NSThread currentThread]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

//get方法登陆
- (void)getLogin
{
    NSString *urlStr = @"http://127.0.0.1/login.php?username=june&password=jjjuuunnneee";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // GET方法
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@  %@", responseObject, [NSThread currentThread]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

//get请求
- (void)getDemo
{
    NSString *urlStr = @"http://127.0.0.1/test.json";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // GET方法
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 已经把反序列化完成的结果都直接返回了。可以更新UI了
        NSLog(@"%@  %@", responseObject, [NSThread currentThread]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    NSLog(@"完成");
    
}
@end
