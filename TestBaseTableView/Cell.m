//
//  Cell.m
//  TestBaseTableView
//
//  Created by ys on 16/5/26.
//  Copyright © 2016年 jzh. All rights reserved.
//

#import "Cell.h"

#import "Model.h"

@implementation Cell

- (CGFloat)setContentWithModel:(BaseModel *)model
{
    self.backgroundColor = [UIColor yellowColor];
    Model *mmodel = (Model *)model;
    self.textLabel.text = mmodel.cname;
    self.detailTextLabel.text = mmodel.sex;
    return kDefaultCellHeight * 2;
}



@end
