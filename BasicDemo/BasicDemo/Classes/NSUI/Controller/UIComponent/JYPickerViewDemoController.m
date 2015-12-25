//
//  JYPickerViewDemoController.m
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/17.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import "JYPickerViewDemoController.h"
#import "Province.h"

@interface JYPickerViewDemoController ()

@property (nonatomic,strong)NSArray *provinces;

@property (nonatomic,assign)NSInteger indexOfProvice;//当前默认选中的省份

@end

@implementation JYPickerViewDemoController

-(NSArray *)provinces{
    if (!_provinces) {
        _provinces = [Province provinceList];
    }
    
    return _provinces;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 100, 320, 216)];
    // 显示选中框
    pickerView.showsSelectionIndicator=YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [self.view addSubview:pickerView];
    
    NSLog(@"%@",self.provinces);
    
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {//省分
        return self.provinces.count;
    }
    
    //获取对应省份的城市个数
    Province *province = self.provinces[self.indexOfProvice];
    
    return province.cities.count;
    
}

//显示数据
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if(component == 0){//显示省份的名字
        //对应列行的省份
        Province *province = self.provinces[row];
        return province.name;
    }
    
    //获取选中的城市，显示城市名字
    Province *selectedProvice = self.provinces[self.indexOfProvice];
    return selectedProvice.cities[row];
}

//选中行时
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {//第一列省的选中改变后，就要更新第二列数据
        //更新选中省份的索引
        self.indexOfProvice = row;
        //部份刷新
        [pickerView reloadComponent:1];
        //不管之前第二列选中第几行，重新刷新数据后，都显示每二列的第一行
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
}

//设置宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (component == 0) {
        return 80;
    }
    
    return 200;
}

@end
