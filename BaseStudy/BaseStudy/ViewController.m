//
//  ViewController.m
//  BaseStudy
//
//  Created by 李涛 on 2018/7/31.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

#import "ViewController.h"
#import "BaseViewController.h"
#import "BlockViewController.h"
#import "ViewDrawStudyViewController.h"

static NSString *const identifier = @"cell";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"view 将要出现");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"view 已经出现");
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[NSClassFromString(self.dataArr[indexPath.row]) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

#pragma mark - httpRequest

#pragma mark - click

#pragma mark - private method

#pragma mark - setter

#pragma mark - init

- (void)initUI{
    self.dataArr = [NSMutableArray arrayWithArray:@[@"BaseViewController", @"BlockViewController", @"ViewDrawStudyViewController", @"RuntimeViewController", @"ObjectViewController", @"RuntimeRunloopViewController", @"RunLoopViewController", @"InterviewGCDViewController", @"MemoryManagerViewController"]];
    
    self.tableView.frame = CGRectMake(0, NavH, ScreenWidth, ScreenHeight-NavH);
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.layer.masksToBounds = YES;
        _tableView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
    }
    return _tableView;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
