//
//  JYCollectionViewController.h
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/16.
//  Copyright © 2015年 马俊炎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYCollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic)UICollectionView *collectionView;

@end
