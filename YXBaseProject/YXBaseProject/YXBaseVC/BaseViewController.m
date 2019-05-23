//
//  BaseViewController.m
//  YXVC
//
//  Created by 李涛 on 2017/5/5.
//  Copyright © 2017年 Tao_Lee. All rights reserved.
//

#import "BaseViewController.h"

#import "UINavigationController+FDFullscreenPopGesture.h"


@interface BaseViewController ()
{
    BOOL _statusBarHidden;
    UIStatusBarStyle _statusBarStyle;
    
}

@end

@implementation BaseViewController


- (instancetype)init{
    self = [super init];
    if (self) {
        _statusBarHidden = NO;
        _statusBarStyle = UIStatusBarStyleDefault;

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.fd_prefersNavigationBarHidden = YES;
    [self initConfig];

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count == 1) {
            self.tabBarController.tabBar.hidden = NO;
        }
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count == 1) {
            self.tabBarController.tabBar.hidden = NO;
        }
        if (self.navigationController.viewControllers.count== 2 && self.tabBarController.tabBar.hidden == NO) {
            self.tabBarController.tabBar.hidden = YES;
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark - httpRequest

#pragma mark - private method
- (void)addBGReturenKeyboard{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEndEdit:)];
    [self.view addGestureRecognizer:tap];
}



#pragma mark - click
- (void)showStatusBar{
    _statusBarHidden = NO;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)hideStatusBar{
    _statusBarHidden = YES;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)prefersStatusBarHidden{
    return _statusBarHidden;
}

- (void)showLightStatusBarStyle{
    _statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)showDarkStatusBarStyle{
    _statusBarStyle = UIStatusBarStyleDefault;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return _statusBarStyle;
}
- (void)tapEndEdit:(UITapGestureRecognizer *)tap{
    [self.view endEditing:YES];
}

- (void)forbidSweepPopBack{
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO;
    }
}

#pragma mark - init

- (void)initConfig{
    _statusBarHidden = NO;
    _statusBarStyle = UIStatusBarStyleDefault;
    self.view.backgroundColor = [UIColor whiteColor];
    [self showDarkStatusBarStyle];
}

- (void)dealloc{
    NSLog(@"%@销毁了",self.class);
}


@end
