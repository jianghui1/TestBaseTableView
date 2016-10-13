//
//  BaseTableModelController.m
//  TestBaseTableView
//
//  Created by ys on 16/5/26.
//  Copyright © 2016年 jzh. All rights reserved.
//

#import "BaseTableModelController.h"

#import "BaseTableCell.h"

@interface BaseTableModelController ()

@end

@implementation BaseTableModelController


- (void)setDataDictionary:(NSMutableDictionary *)dataDictionary
{
    if (_dataDictionary != dataDictionary) {
//        _dataDictionary = [dataDictionary copy];
        _dataDictionary = dataDictionary;
    }
}

// 子类重写重新赋值
- (Class)getCellClassName:(NSString *)className
{
    if ([className isEqualToString:@"BaseModel"]) {
        return [BaseTableCell class];
    } else {
        return NSClassFromString(className);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataDictionary) {
        return self.dataDictionary.allKeys.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataDictionary) {
        NSArray *array = self.dataDictionary.allKeys;
        NSString *key = array[section];
        NSArray *dataArray = self.dataDictionary[key];
        return dataArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.dataDictionary) {
        return nil;
    }
    
    NSArray *array = self.dataDictionary.allKeys;
    NSString *key = array[indexPath.section];
    NSArray *dataArray = self.dataDictionary[key];
    BaseModel *model = dataArray[indexPath.row];
    BaseTableCell *cell = [tableView dequeueReusableCellWithIdentifier:model.cellClass];
    if (!cell) {
        cell = [[[self getCellClassName:model.cellClass] alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:model.cellClass];
    }
    CGFloat height = [cell setContentWithModel:model];
    if (_delegate && [_delegate respondsToSelector:@selector(getCellHeight:atIndexPath:)]) {
        [_delegate getCellHeight:height atIndexPath:indexPath];
    }
    return cell;
}


@end
