//
//  YXBaseTableViewController.m
//  YXVC
//
//  Created by 李涛 on 2017/7/5.
//  Copyright © 2017年 Tao_Lee. All rights reserved.
//

#import "YXBaseTableViewController.h"
#import "YXBaseVCHeader.h"
#import "UIScrollView+EmptyDataSet.h"

@interface YXBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation YXBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _isShowEmptyData = NO;
    
    /**
     YXCustomRefreshHeader *header = [YXCustomRefreshHeader headerWithRefreshingBlock:^{
     page = 1;
     [ws requestData];
     }];
     self.tableView.mj_header = header;
     header.lastUpdatedTimeLabel.hidden = YES;
     header.stateLabel.hidden = YES;
     [self requestData];
     
     YXCustomRefreshFooter *footer = [YXCustomRefreshFooter footerWithRefreshingBlock:^{
     page += 1;
     [ws requestData];
     }];
     self.tableView.mj_footer = footer;
     
     
     if (arr.count == 20 ) {
     [self.tableView.mj_header endRefreshing];
     [self.tableView.mj_footer endRefreshing];
     if (page == 1) {
     self.dataArr = [NSMutableArray arrayWithArray:arr];
     }else{
     [self.dataArr addObjectsFromArray:arr];
     }
     }else{
     if (page == 1) {
     self.dataArr = [NSMutableArray arrayWithArray:arr];
     }else{
     [self.dataArr addObjectsFromArray:arr];
     }
     [self.tableView.mj_header endRefreshing];
     [self.tableView.mj_footer endRefreshingWithNoMoreData];
     
     }
     [self.tableView reloadData];
     
     
     if (page > 1) {
     page-=1;
     }

     
     */
    
    
    /*
     <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
     
     
     #pragma mark - UICollectionViewDataSource
     - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
     return 0;
     //    return self.dataArr.count;
     }
     
     - (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     
     //    return cell;
     return 0;
     }
     
     #pragma mark - UICollectionViewDelegateFlowLayout
     - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
     
     return CGSizeMake(160, 100);
     }
     
     - (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     
     }
     
     
     - (UICollectionView *)collectionView{
     if (!_collectionView) {
     UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
     layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
     layout.minimumLineSpacing = 20;
     _collectionView = [[UICollectionView alloc] initWithFrame:(CGRectZero) collectionViewLayout:layout];
     _collectionView.dataSource = self;
     _collectionView.delegate = self;
     _collectionView.showsVerticalScrollIndicator = NO;
     _collectionView.showsHorizontalScrollIndicator = NO;
     _collectionView.bounces = YES;
     if (@available(iOS 11.0, *)) {
     _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
     }else {
     self.automaticallyAdjustsScrollViewInsets = NO;
     }
     
     }
     return _collectionView;
     }
     */
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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

#pragma mark - DZNEmptyDataSetSource
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"service_nodata"];
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -30*kSCALE;
}

#pragma mark - DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return self.isShowEmptyData;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    
}

//- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView{
//    
//}

//- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
//{
//    self.loading = YES;
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.loading = NO;
//    });
//}


//- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
//{
//    return self.isLoading;
//}
//

/*
     MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
     page = 1;
     [ws requestData];
     }];
     self.tableView.mj_header = header;
     header.lastUpdatedTimeLabel.hidden = YES;
     header.stateLabel.hidden = YES;
     [self requestData];
 
     MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
     page += 1;
     [ws requestData];
     }];
     self.tableView.mj_footer = footer;
 
 
 
     if (arr.count == 20 ) {
     [self.tableView.mj_header endRefreshing];
     [self.tableView.mj_footer endRefreshing];
     if (page == 1) {
     self.dataArr = [NSMutableArray arrayWithArray:arr];
     }else{
     [self.dataArr addObjectsFromArray:arr];
     }
     }else{
     if (page == 1) {
     self.dataArr = [NSMutableArray arrayWithArray:arr];
     }else{
     [self.dataArr addObjectsFromArray:arr];
     }
     [self.tableView.mj_header endRefreshing];
     [self.tableView.mj_footer endRefreshingWithNoMoreData];

     }
     [self.tableView reloadData];
     } error:^(BOOL res, id error) {
     if (page > 1) {
     page -= 1;
     }
     [self.tableView.mj_header endRefreshing];
     [self.tableView.mj_footer endRefreshing];
 */



#pragma mark - httpRequest

#pragma mark - click

#pragma mark - private method

#pragma mark - setter

#pragma mark - init

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.layer.masksToBounds = YES;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
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
