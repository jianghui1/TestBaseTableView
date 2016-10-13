//
//  NetWorkHelper.m
//  TestBaseTableView
//
//  Created by ys on 16/5/27.
//  Copyright © 2016年 jzh. All rights reserved.
//

#import "NetWorkHelper.h"

#import <AFNetworking.h>

@interface NetWorkHelper ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSURLSessionTask *task;

- (NetWorkHelper * (^)(NSString *))addAPI;
- (NetWorkHelper * (^)(NSDictionary *))addParameter;
- (NetWorkHelper * (^)(NetWorkHelperRequestType))addRequestType;

@end

@implementation NetWorkHelper


// 发送请求
- (void)requestAPI:(NSString *)api
        parameters:(NSDictionary *)parameters
       requestType:(NetWorkHelperRequestType)requestType
           success:(NetWorkHelperRequestSuccess)success
              fail:(NetWorkHelperRequestFail)fail
{
//    [[[[self requestAPI:^NSString *(NSString *apiString) {
//        apiString = api;
//        return apiString;
//    }] requestParameter:^NSDictionary *(NSDictionary *parameterDic) {
//        parameterDic = parameters;
//        return parameterDic;
//    }] requetType:^NetWorkHelperRequestType(NetWorkHelperRequestType type) {
//        type = requestType;
//        return type;
//    }] requestSuccess:^(NSDictionary *response) {
//        if (response) {
//            success(response);
//        }
//    } fail:^(NSError *error) {
//        if (error) {
//            fail(error);
//        }
//    }];
    
    [self.addAPI(api).addParameter(parameters).addRequestType(requestType) requestSuccess:^(NSDictionary *response) {
        if (response) {
            success(response);
        }
    } fail:^(NSError *error) {
        if (error) {
            fail(error);
        }
    }];
}

- (NetWorkHelper *)requestAPI:(NSString * (^)(NSString *))requestAPI
{
    self.api = requestAPI(_api);
    return self;
}
- (NetWorkHelper *)requestParameter:(NSDictionary * (^)(NSDictionary *))requestParameter
{
    self.parameter = requestParameter(_parameter);
    return self;
}
- (NetWorkHelper *)requetType:(NetWorkHelperRequestType (^)(NetWorkHelperRequestType))requestType
{
    self.requestType = requestType(_requestType);
    return self;
}

- (NetWorkHelper * (^)(NSString *))addAPI
{
    return ^ (NSString *api) {
        _api = api;
        return self;
    };
}
- (NetWorkHelper * (^)(NSDictionary *))addParameter
{
    return ^ (NSDictionary *dic) {
        _parameter = dic;
        return self;
    };
}
- (NetWorkHelper * (^)(NetWorkHelperRequestType))addRequestType
{
    return ^ (NetWorkHelperRequestType type) {
        _requestType = type;
        return self;
    };
}

- (void)requestSuccess:(NetWorkHelperRequestSuccess)success
                  fail:(NetWorkHelperRequestFail)fail
{
    if (!self.manager) {
        self.manager =
        // 应该获取一个全局唯一的 manager
        self.manager = [AFHTTPSessionManager manager];
        self.manager.responseSerializer.acceptableContentTypes = [self.manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    }
    
    if (self.requestType == NetWorkHelperRequestType_POST) {
        // POST请求
        self.task = [self.manager POST:self.api
                            parameters:self.parameter
                              progress:nil
                               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                   if (responseObject) {
                                       success(responseObject);
                                   }
                               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                   if (error) {
                                       fail(error);
                                   }
                               }];
    } else {
        // GET请求
        self.task = [self.manager GET:self.api
                           parameters:self.parameter
                             progress:nil
                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                  if (responseObject) {
                                      success(responseObject);
                                  }
                              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                  if (error) {
                                      fail(error);
                                  }
                              }];
    }
}
- (void)cancel
{
    if (self.task) {
        [self.task cancel];
    }
}

@end
