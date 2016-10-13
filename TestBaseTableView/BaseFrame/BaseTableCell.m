//
//  BaseTableCell.m
//  TestBaseTableView
//
//  Created by ys on 16/5/26.
//  Copyright © 2016年 jzh. All rights reserved.
//

#import "BaseTableCell.h"

@implementation BaseTableCell

// 设置内容的方法
- (CGFloat)setContentWithModel:(BaseModel *)model
{
    self.textLabel.text = model.name;
    
    return kDefaultCellHeight;
}


@end
