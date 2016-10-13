//
//  BaseTableController.m
//  TestBaseTableView
//
//  Created by ys on 16/5/26.
//  Copyright © 2016年 jzh. All rights reserved.
//

#import "BaseTableController.h"
#import "BaseTableModelController.h"
#import "BaseModel.h"
#import "BaseTableCell.h"

@interface BaseTableController ()<BaseTableModelControllerDelegate>

@property (nonatomic, strong) BaseTableModelController *btMC;
// 存储indexpath对应的高度
@property (nonatomic, strong) NSMutableDictionary *heightDic;
// 存储页数
@property (nonatomic, assign) NSInteger pageId;
@property (nonatomic, weak) UIRefreshControl *control;

@end

@implementation BaseTableController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super init]) {
        self.tableViewStyle = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView的样式
    [self setupTableView];
}

#pragma mark - 设置tableView的样式
- (void)setupTableView
{
    self.tableView = [[BaseTableView alloc] initWithFrame:self.view.frame style:self.tableViewStyle];
    self.tableView.backgroundColor = [UIColor redColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self.btMC;
    self.btMC.delegate = self;
    [self.view addSubview:self.tableView];
    
    // 给tableView添加上拉和下拉刷新
    [self addTopAndBottomRefresh];
}

#pragma mark - 给tableView添加上拉和下拉刷新
- (void)addTopAndBottomRefresh
{
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    [control addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.control = control;
    [self.tableView addSubview:control];
}
- (void)refresh
{
    // 这里只需要修改参数中的pageId就可以继续请求
    [self requstData];
}
- (void)handleWithDifferentState:(RequestDataState)state
{
    [self.control endRefreshing];
    if (state == RequestDataState_Correct) {
        // 这里必须要重写，进行数据的刷新
        if (self.dataKey == nil) {
            return;
        }
        NSArray *keys = self.dataKey.allKeys;
        [keys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *array = self.dataKey[obj];
            if (array.count > 1) { // 最多整两层
                id firstValue = self.jsonDictionary[array[0]];
                if ([firstValue isKindOfClass:[NSArray class]]) {
                    NSMutableArray *minArray = [NSMutableArray array];
                    for (NSDictionary *minDic in firstValue) {
                        BaseModel *model = [self getModelClass];
                        [model setValuesForKeysWithDictionary:minDic];
                        [minArray addObject:model];
                    }
                    [self.dataDictionary setObject:minArray forKey:@(idx)];
                }
                if ([firstValue isKindOfClass:[NSDictionary class]] && array.count > 2) {
                    id secondValue = firstValue[array[1]];
                    if ([secondValue isKindOfClass:[NSArray class]]) {
                        NSMutableArray *minArray = [NSMutableArray array];
                        for (NSDictionary *minDic in firstValue) {
                            BaseModel *model = [self getModelClass];
                            [model setValuesForKeysWithDictionary:minDic];
                            [minArray addObject:model];
                        }
                        [self.dataDictionary setObject:minArray forKey:@(idx)];
                    }
                }
            }
        }];
        self.btMC.dataDictionary = self.dataDictionary;
        [self.tableView reloadData];
    }
    
    [super handleWithDifferentState:state];
}

// 数据源的类型
- (BaseModel *)getModelClass
{
    return [[BaseModel alloc] init];
}

- (BaseTableModelController *)btMC
{
    if (!_btMC) {
        _btMC = [[BaseTableModelController alloc] init];
    }
    return _btMC;
}

- (NSMutableDictionary *)dataDictionary
{
    if (!_dataDictionary) {
        _dataDictionary = [NSMutableDictionary dictionary];
    }
    return _dataDictionary;
}

- (BaseModel *)getModelWithDictionary:(NSMutableDictionary *)dic indexPath:(NSIndexPath *)indexPath
{
    NSString *key = self.dataDictionary.allKeys[indexPath.section];
    NSArray *dataArray = self.dataDictionary[key];
    BaseModel *model = dataArray[indexPath.row];
    return model;
}


#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BaseModel *model = [self getModelWithDictionary:self.dataDictionary indexPath:indexPath];
    if (model.detailClass != nil) {
        // 进行跳转的操作
        NSLog(@"%@", model.detailClass);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.heightDic[indexPath] floatValue];
}

#pragma mark - BaseTableModelControllerDelegate
- (void)getCellHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath
{
    [self.heightDic setObject:@(height) forKey:indexPath];
}

- (NSMutableDictionary *)heightDic
{
    if (!_heightDic) {
        _heightDic = [NSMutableDictionary dictionary];
    }
    return _heightDic;
}

@end
