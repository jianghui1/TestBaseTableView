//
//  BaseViewController.h
//  TestBaseTableView
//
//  Created by ys on 16/5/26.
//  Copyright © 2016年 jzh. All rights reserved.
//  所有控制器的父类

#import <UIKit/UIKit.h>

#import "NetWorkHelper.h"

typedef enum : NSUInteger {
    RequestDataState_Correct, // 200
    RequestDataState_Exception, // 非200
    RequestDataState_Error, // 请求失败
} RequestDataState;

@interface BaseViewController : UIViewController

/**
 子类只需要重写这几个属性的getter方法返回不同的接口详情
 */
// 请求接口
@property (nonatomic, copy) NSString *requestUrl;
// 请求参数
@property (nonatomic, strong) NSDictionary *requestParameter;
// 请求参数
@property (nonatomic, assign) NetWorkHelperRequestType requestType;
// 数据
@property (nonatomic, strong) NSDictionary *jsonDictionary;
// 错误
@property (nonatomic, strong) NSError *error;
// 信息
@property (nonatomic, copy) NSString *message;
// 请求数据的方法
- (void)requstData;
/**
 * 解析数据的所有key组成的字典
 * key值可以按照数字依次排列
 * value必须是个数组，可以是包含一个元素的数组
 */
@property (nonatomic, strong) NSDictionary *dataKey;

// 创建一个请求对象
@property (nonatomic, strong) NetWorkHelper *netWorkHelper;

// 子类可以重写处理数据的方法来进行满足不同状态的处理
- (void)handleWithDifferentState:(RequestDataState)state;

@end
