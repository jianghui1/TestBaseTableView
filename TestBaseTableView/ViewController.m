//
//  ViewController.m
//  TestBaseTableView
//
//  Created by ys on 16/5/26.
//  Copyright © 2016年 jzh. All rights reserved.
//

#import "ViewController.h"

#import "Model.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (BaseModel *)getModelClass
{
    return [[Model alloc] initWithCellClass:@"Cell" detailClass:nil];
}

- (NSString *)requestUrl
{
    return @"http://c.m.163.com/nc/topicset/ios/radio/index.html";
}

- (NSDictionary *)dataKey
{
    return @{
             @"0":@[@"cList",
                    @"tList"
                    ]
             };
}


@end
