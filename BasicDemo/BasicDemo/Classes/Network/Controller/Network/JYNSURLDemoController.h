//
//  JYNSURLDemoController.h
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/18.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYBasicController.h"

@interface JYNSURLDemoController : JYBasicController <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

{
    NSMutableData *receivedData;
    NSURLConnection *theConnection;
}

@end
