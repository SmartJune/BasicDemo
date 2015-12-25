//
//  JYItemMessage.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/15.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYItemMessage.h"
#import "JYNavigationBarDemoController.h"

@implementation JYItemMessage

//NS_ENUM，定义状态等普通枚举
typedef NS_ENUM(NSUInteger, ClassName) {
    //UI控件
    ButtonDemo = 1,
    LabelDemo = 2,
    TextFieldDemo = 3,
    ImageViewDemo = 4,
    ProgressViewDemo = 5,
    SliderDemo = 6,
    SegmentedControlDemo = 7,
    SwitchDemo = 8,
    ActivityIndicatorDemo = 9,
    AlertViewDemo = 10,
    ActionSheetDemo = 11,
    ScrollViewDemo = 12,
    TextViewDemo = 13,
    TableViewDemo = 14,
    CollectionViewDemo = 15,
    PickerViewDemo = 16,
    DatePickerDemo = 17,
    WebViewDemo = 18,
    ToolbarDemo = 19,
    NavigationBarDemo = 20,
    
    //Core XXX
    CoreGraphicsDemo = 101,
    CoreAnimationDemo = 102,
    CoreImageDemo = 103,
    CoreTextDemo = 104,
    
    //散乱的
    KV_Demo = 201,
    SingletonDemo = 202,
    
    //多线程
    NSThreadDemo = 100,
    pthreadDemo = 200,
    GCDDemo = 300,
    NSOperationDemo = 400,
    
    //网络
    NSURLDemo = 10100,
    NSURLSessionDemo = 10200,
    
    //数据存储
    NSKeyedArchiverDemo = 20100,
    NSUserDefaultsDemo = 20200,
    WriteToFileDemo = 20300,
    SQLiteDemo = 20400,
    CoreDataDemo = 20500,
    
    //第三方框架
    SDWebImageDemo = 30100,
    AFNetworkingDemo = 30200,
    FMDBDemo = 30300,
    MBProgressHUDDemo = 30400,
    
    TTGStateError,
    TTGStateUnknow
};


+ (NSString *)findClassNameByID:(int)ID
{
    switch (ID) {
        //UI控件
        case ButtonDemo:
            NSLog(@"跳到button");
            return @"JYButtonDemoController";
            break;
        case LabelDemo:
            NSLog(@"跳到label");
            return @"JYLabelDemoController";
            break;
        case TextFieldDemo:
            return @"JYTextFieldDemoController";
            break;
        case ImageViewDemo:
            return @"JYImageViewDemoController";
            break;
        case ProgressViewDemo:
            return @"JYProgressViewController";
            break;
        case SliderDemo:
            return @"JYSliderDemoController";
            break;
        case SegmentedControlDemo:
            return @"JYSegmentedDemoController";
            break;
        case SwitchDemo:
            return @"JYSwitchDemoController";
            break;
        case ActivityIndicatorDemo:
            return @"JYIndicatorDemoController";
            break;
        case AlertViewDemo:
            return @"JYAlertViewDemoController";
            break;
        case ActionSheetDemo:
            return @"JYActionSheetDemoController";
            break;
        case ScrollViewDemo:
            return @"JYScrollViewDemoController";
            break;
        case TextViewDemo:
            return @"JYTextViewDemoController";
            break;
        case TableViewDemo:
            return @"JYTableViewDemoController";
            break;
        case CollectionViewDemo:
            return @"JYCollectionViewController";
            break;
        case PickerViewDemo:
            return @"JYPickerViewDemoController";
            break;
        case DatePickerDemo:
            return @"JYDatePickerDemoController";
            break;
        case WebViewDemo:
            return @"JYWebViewDemoController";
            break;
        case ToolbarDemo:
            return @"JYToolBarDemoController";
            break;
        case NavigationBarDemo:
            return @"JYNavigationBarDemoController";
            break;
            
        //Core XXX
        case CoreGraphicsDemo:
            return @"JYCoreGraphicsController";
            break;
        case CoreAnimationDemo:
            return @"JYCoreAnimationController";
            break;
        case CoreImageDemo:
            return @"JYCoreImageController";
            break;
        case CoreTextDemo:
            return @"JYCoreTextController";
            break;
            
        //散乱的
        case KV_Demo:
            return @"JYKV_DemoController";
            break;
        case SingletonDemo:
            return @"JYSingletonController";
            break;
            
        //多线程
        case NSThreadDemo:
            return @"JYNSThreadDemoController";
            break;
        case pthreadDemo:
            return @"JYPThreadDemoController";
            break;
        case GCDDemo:
            return @"JYGCDDemoController";
            break;
        case NSOperationDemo:
            return @"JYOperationDemoController";
            break;
            
        //网络
        case NSURLDemo:
            return @"JYNSURLDemoController";
            break;
        case NSURLSessionDemo:
            return @"JYURLSessionDemoController";
            break;
            
        //数据存储
        case NSKeyedArchiverDemo:
            return @"JYKeyedArchiverController";
            break;
        case NSUserDefaultsDemo:
            return @"JYUserDefaultDemoController";
            break;
        case WriteToFileDemo:
            return @"JYWriteToFileDemoController";
            break;
        case SQLiteDemo:
            return @"JYSQLiteDemoController";
            break;
        case CoreDataDemo:
            return @"JYCoreDataDemoController";
            break;
            
        //第三方框架
        case SDWebImageDemo:
            return @"JYSDWebImageController";
            break;
        case AFNetworkingDemo:
            return @"JYAFNDemoController";
            break;
        case FMDBDemo:
            return @"JYFMDBDemoController";
            break;
        case MBProgressHUDDemo:
            return @"JYMBProgressHUDController";
            break;
            
        default:
            return @"不是button这里";
            break;
            
    }
}

@end
