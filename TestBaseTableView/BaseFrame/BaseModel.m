//
//  BaseModel.m
//  TestBaseTableView
//
//  Created by ys on 16/5/26.
//  Copyright © 2016年 jzh. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (instancetype)init
{
    if (self = [super init]) {
        self.cellClass = @"BaseModel";
    }
    return self;
}

- (instancetype)initWithCellClass:(NSString *)className detailClass:(NSString *)detailClass
{
    if (self = [super init]) {
        self.cellClass = className;
        self.detailClass = detailClass;
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

@end
