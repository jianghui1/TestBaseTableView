//
//  BaseTableController.h
//  TestBaseTableView
//
//  Created by ys on 16/5/26.
//  Copyright © 2016年 jzh. All rights reserved.
//  所有tableView的父类

#import "BaseViewController.h"
#import "BaseTableView.h"
#import "BaseModel.h"

@protocol BaseTableControllerDelegate <NSObject>

@optional
// 数据源的类型
- (BaseModel *)getModelClass;

@end

@interface BaseTableController : BaseViewController<UITableViewDelegate, BaseTableControllerDelegate>

@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, assign) UITableViewStyle tableViewStyle; // 用来创建 tableView
@property (nonatomic, strong) NSMutableDictionary *dataDictionary;

- (instancetype)initWithStyle:(UITableViewStyle)style;

@end
