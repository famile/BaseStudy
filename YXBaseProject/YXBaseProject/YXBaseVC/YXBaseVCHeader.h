//
//  YXBaseVCHeader.h
//  YXBaseProject
//
//  Created by 李涛 on 2019/5/15.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#ifndef YXBaseVCHeader_h
#define YXBaseVCHeader_h

#import "CommonTools.h"
#import "MyControl.h"
#import "UIView+Extension.h"

#define kScreenWidth      [UIScreen mainScreen].bounds.size.width
#define kScreenHeight      [UIScreen mainScreen].bounds.size.height
#define kScreenBounds     [UIScreen mainScreen].bounds

// 状态栏的高度
#define DEVICE_STATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height
// nav Bar 高度
#define DEVICE_NAVIGATION_BAR_HEIGHT        44

#define NavH   (DEVICE_STATUS_BAR_HEIGHT + DEVICE_NAVIGATION_BAR_HEIGHT)
//底部tabbar高度
#define TabbarH ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
//底部margin高度
#define kTabbarBottomMargin ([[UIApplication sharedApplication] statusBarFrame].size.height>20?34:0)


//字体
#define SystemFont(s)  [UIFont systemFontOfSize:s]
#define CustomBoldFont(s) [UIFont fontWithName:@"PingFangSC-Bold" size:s]
#define CustomLightFont(s) [UIFont fontWithName:@"PingFangSC-Light" size:s]
#define CustomRegularFont(s) [UIFont fontWithName:@"PingFangSC-Regular" size:s]
#define CustomMediumFont(s) [UIFont fontWithName:@"PingFangSC-Medium" size:s]
#define CustomDINFont(s) [UIFont fontWithName:@"DINPro-CondBold" size:s]

//16进制颜色
#define ColorFrom0xRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ColorFrom0xRGBWithAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

//防止循环引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
//适配时放缩比例
#define kSCALE ([UIScreen mainScreen].bounds.size.width/375.0) //以主流iPhone6为基准

#endif /* YXBaseVCHeader_h */
