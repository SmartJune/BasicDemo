//
//  Staff+CoreDataProperties.h
//  BasicDemo
//
//  Created by 马俊炎 on 15/12/20.
//  Copyright © 2015年 马俊炎. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Staff.h"

NS_ASSUME_NONNULL_BEGIN

@interface Staff (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSNumber *height;

@end

NS_ASSUME_NONNULL_END
