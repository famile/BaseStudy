//
//  ViewController.m
//  YXBaseProject
//
//  Created by 李涛 on 2019/5/15.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "ViewController.h"
#import "YXBaseVC/YXBaseTableViewController.h"
#import "YXNewWebViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - httpRequest

#pragma mark - click
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    YXNewWebViewController *vc = [[YXNewWebViewController alloc] init];
    vc.urlStr = @"http://bibao.qmshenghuo.com/index.php/h5/numbergame/index?user_id=2&user_token=2";
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - private method

#pragma mark - setter

#pragma mark - init


@end
