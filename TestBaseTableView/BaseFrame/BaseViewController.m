//
//  BaseViewController.m
//  TestBaseTableView
//
//  Created by ys on 16/5/26.
//  Copyright © 2016年 jzh. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requstData];
    
}

// 请求数据的方法
- (void)requstData
{
    if (self.requestUrl) {
        self.netWorkHelper = [[NetWorkHelper alloc] init];
        [[[[self.netWorkHelper requestAPI:^NSString *(NSString *apiString) {
            apiString = self.requestUrl;
            return apiString;
        }] requestParameter:^NSDictionary *(NSDictionary *parameterDic) {
            parameterDic = self.requestParameter;
            return parameterDic;
        }] requetType:^NetWorkHelperRequestType(NetWorkHelperRequestType type) {
            type = self.requestType;
            return type;
        }] requestSuccess:^(NSDictionary *response) {
//            if ([response[@"Code"] integerValue] == 200) {
                self.jsonDictionary = response;
                [self handleWithDifferentState:RequestDataState_Correct];
//            } else {
////                self.message // 需要提示的信息
//                [self handleWithDifferentState:RequestDataState_Exception];
//            }
        } fail:^(NSError *error) {
            self.error = error;
            [self handleWithDifferentState:RequestDataState_Error];
        }];
    }
}

// 子类可以重写处理数据的方法来进行满足不同状态的处理
- (void)handleWithDifferentState:(RequestDataState)state
{
    switch (state) {
        case RequestDataState_Correct: // 200
            NSLog(@"解析数据");
            break;
            
        case RequestDataState_Exception: // 非200
            NSLog(@"弹出提示信息");
            break;
            
        case RequestDataState_Error: // 请求失败
            NSLog(@"出现背景提示图");
            break;
    }
}

@end
