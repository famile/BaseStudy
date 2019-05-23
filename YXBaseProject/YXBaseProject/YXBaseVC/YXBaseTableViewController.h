//
//  YXBaseTableViewController.h
//  YXVC
//
//  Created by 李涛 on 2017/7/5.
//  Copyright © 2017年 Tao_Lee. All rights reserved.
//

#import "YXBaseDetailViewController.h"

@interface YXBaseTableViewController : YXBaseDetailViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

/** 是否显示空数据 */
@property (nonatomic, assign) BOOL isShowEmptyData;

/** 未连接网络或者网络错误 */
@property (nonatomic, assign) BOOL notConnect;


@end
