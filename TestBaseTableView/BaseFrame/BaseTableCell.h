//
//  BaseTableCell.h
//  TestBaseTableView
//
//  Created by ys on 16/5/26.
//  Copyright © 2016年 jzh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseModel.h"

#define kDefaultCellHeight 44.0

@interface BaseTableCell : UITableViewCell

// 设置内容的方法
- (CGFloat)setContentWithModel:(BaseModel *)model;


@end
