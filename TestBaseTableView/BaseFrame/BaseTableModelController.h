//
//  BaseTableModelController.h
//  TestBaseTableView
//
//  Created by ys on 16/5/26.
//  Copyright © 2016年 jzh. All rights reserved.
//  所有tableView的数据类

#import <UIKit/UIKit.h>

@protocol BaseTableModelControllerDelegate <NSObject>

@optional
- (Class)getCellClassName:(NSString *)className;
- (void)getCellHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath;

@end

@interface BaseTableModelController : NSObject<UITableViewDataSource, BaseTableModelControllerDelegate>

@property (nonatomic, strong) NSMutableDictionary *dataDictionary;
@property (nonatomic, assign) id<BaseTableModelControllerDelegate> delegate;


@end
