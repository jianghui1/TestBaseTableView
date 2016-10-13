//
//  BaseModel.h
//  TestBaseTableView
//
//  Created by ys on 16/5/26.
//  Copyright © 2016年 jzh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

// cell的类型
@property (nonatomic, copy) NSString *cellClass;
// 详情页类型
@property (nonatomic, copy) NSString *detailClass;
- (instancetype)initWithCellClass:(NSString *)className detailClass:(NSString *)detailClass;

@property (nonatomic, copy) NSString *name;

@end
