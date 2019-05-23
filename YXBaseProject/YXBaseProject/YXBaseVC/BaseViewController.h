//
//  BaseViewController.h
//  YXVC
//
//  Created by 李涛 on 2017/5/5.
//  Copyright © 2017年 Tao_Lee. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseViewController : UIViewController



@property (nonatomic, strong) NSURLSessionTask *task;

@property (nonatomic, copy) void(^goBackHandle)(void);


/**
 显示状态栏
 */
- (void)showStatusBar;

/**
 隐藏状态栏
 */
- (void)hideStatusBar;

/**
 显示白色状态栏
 */
- (void)showLightStatusBarStyle;

/**
 显示黑色的状态栏
 */
- (void)showDarkStatusBarStyle;

/** 添加点击键盘回收 */
- (void)addBGReturenKeyboard;


/** 禁用返回手势 */
- (void)forbidSweepPopBack;

@end
