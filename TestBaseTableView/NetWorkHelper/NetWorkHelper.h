//
//  NetWorkHelper.h
//  TestBaseTableView
//
//  Created by ys on 16/5/27.
//  Copyright © 2016年 jzh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    NetWorkHelperRequestType_GET, // GET请求方式（默认）
    NetWorkHelperRequestType_POST, // POST请求方式
} NetWorkHelperRequestType;

// 请求成功
typedef void(^NetWorkHelperRequestSuccess)(NSDictionary *response);
// 请求失败
typedef void(^NetWorkHelperRequestFail)(NSError *error);

@interface NetWorkHelper : NSObject

// 请求接口
@property (nonatomic, copy) NSString *api;
// 请求参数
@property (nonatomic, strong) NSDictionary *parameter;
// 请求方式
@property (nonatomic, assign) NetWorkHelperRequestType requestType;

// 发送请求
- (void)requestAPI:(NSString *)api
        parameters:(NSDictionary *)parameters
       requestType:(NetWorkHelperRequestType)requestType
           success:(NetWorkHelperRequestSuccess)success
              fail:(NetWorkHelperRequestFail)fail;

- (NetWorkHelper *)requestAPI:(NSString * (^)(NSString *apiString))requestAPI;
- (NetWorkHelper *)requestParameter:(NSDictionary * (^)(NSDictionary *parameterDic))requestParameter;
- (NetWorkHelper *)requetType:(NetWorkHelperRequestType (^)(NetWorkHelperRequestType type))requestType;
- (void)requestSuccess:(NetWorkHelperRequestSuccess)success
                  fail:(NetWorkHelperRequestFail)fail;
- (void)cancel;

@end
