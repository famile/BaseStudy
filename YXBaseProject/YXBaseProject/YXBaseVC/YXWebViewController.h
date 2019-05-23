//
//  YXWebViewController.h
//  YXVC
//
//  Created by 李涛 on 2017/12/1.
//  Copyright © 2017年 Tao_Lee. All rights reserved.
//

#import "YXBaseDetailViewController.h"

@interface YXWebViewController : YXBaseDetailViewController


/**
 url地址
 */
@property (nonatomic, copy) NSString *urlStr;

/**
 静态html
 */
@property (nonatomic, copy) NSString *contentStr;


/**
 使用网页标题（默认）
 */
@property (nonatomic, assign) BOOL useWebTitle;

/**
 自定义标题
 */
@property (nonatomic, copy) NSString *titleStr;

/** 点击返回直接返回（默认一级一级返回） */
@property (nonatomic, assign) BOOL directPop;

/** js回调 */
@property (nonatomic, copy) void(^receiveJSHandle)(NSString *name, id json);

/**
 添加js回调名称
 */
- (void)addScriptHandleName:(NSString *)name;


/**
 创建导航栏（重写或者（调用super方法））
 */
- (void)createNav;

@end
