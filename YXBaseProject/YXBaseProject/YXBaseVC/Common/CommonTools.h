//
//  CommonTool.h
//  qianxiheiOS
//
//  Created by ZSC on 15/6/11.
//  Copyright (c) 2015年 qxhiOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "YXConstantManager.h"


@interface CommonTools : NSObject


/**
 获取字符串宽度

 @param textStr <#textStr description#>
 @param font <#fontSize description#>
 @return <#return value description#>
 */
+(CGFloat)getZSCTextWidth:(NSString *)textStr
          andTextFont:(UIFont *)font;



/**
 获取字符串高度

 @param textStr <#textStr description#>
 @param width <#width description#>
 @param font <#fontSize description#>
 @return <#return value description#>
 */
+ (CGFloat)getZSCTextHight:(NSString *)textStr andWidth:(CGFloat)width andTextFont:(UIFont *)font;

/**
 *  不需要遵循代理的警告视图
 *
 *  @param mainTitle      主标题
 *  @param secondaryTitle 次标题
 */
+ (void)showAlertWithMainTitle:(NSString *)mainTitle
             andSecondaryTitle:(NSString *)secondaryTitle;
+ (void)showAlertWithMoreTitle:(NSString *)mainTitle andMessageTitle:(NSString *)messageTitle;

/**
 *  打开
 */
+ (void)openAppaleShopWithAppleID:(NSString *)appleID;

/**
 钱进行转换（分转换为元）
 
 @param money <#money description#>
 @return <#return value description#>
 */
+ (NSString *)getAmountOfMoneyWithPercentMoney:(NSString *)money;

#pragma mark - 时间处理

/**
 *  获取时间戳（s）
 *
 *  @return 时间戳
 */
+ (NSTimeInterval)timeSp;

+ (NSString*)getCurrentTimestamp;

/**
 *  获取时间间隔(时间戳与当前时间间隔,如论坛发帖时间)
 *
 *  @param timeSp 时间戳
 *
 *  @return 时间
 */
+ (NSString *)timeInterval:(NSString *)timeSp;

/**
 *  获取当前时间
 *
 *  @return 当前时间
 */
+ (NSString *)currentTime;


/** 明天 */
+ (NSString *)tomorrowDate;

/**
 *  转换成标准时间
 *  @param numTime 请求获取时间number型
 *  @return 标准时间
 */
+ (NSString *)standardTime:(NSNumber *)numTime;


/**
 时间戳转化为Date

 @param timeSp <#timeSp description#>
 @return <#return value description#>
 */
+ (NSDate *)dateWithTimeSp:(NSInteger)timeSp;

/**
 时间戳转化为时间

 @param time <#time description#>
 @return <#return value description#>
 */
+ (NSString *)timeStrWithTimeSp:(NSInteger)timeSp;


/**
 时间戳转化为日期


 @param timeSp <#timeSp description#>
 @param style <#style description#>
 @return <#return value description#>
 */
+ (NSString *)dateStrWithTimeSp:(NSInteger)timeSp style:(NSString *)style;


/**
 Date转化为日期

 @param date <#date description#>
 @param style <#style description#>
 @return <#return value description#>
 */
+ (NSString *)dateStrWithDate:(NSDate *)date style:(NSString *)style;


/**
 将date转化为时间戳

 @param date <#date description#>
 @return <#return value description#>
 */
+ (NSInteger)timeSpWithDate:(NSDate *)date;

/**
 *  创建数据模型字段
 *
 *  @param dict      字典
 *  @param className 类名
 */
+(void)createModelFromDictionary:(NSDictionary *)dict className:(NSString *)className;

/**
 *  改变Scroller的内容大小
 *
 *  @param view  当前视图
 *  @param hight 高度
 */
+ (void)setContentSize:(UIScrollView *)view andHight:(CGFloat)hight;

#pragma mark - md5加密
+(NSString *)md5Encryption:(NSString *)inPutString;


#pragma mark - 图片适应--hao
+ (UIImage*)imageWithStretchableName:(NSString *)imageName;


/**
 获取系统版本号
 */
+ (NSString *)getSystemVersion;

/**
 获取app版本号
 */
+ (NSString *)getAppVersion;

/**
 获取build版本
 */
+ (NSString *)getBuildVersion;

/**检测字符串是否是纯数字*/
+ (BOOL)isNumber:(NSString *)num;
/**检测字符串是否是数字或字母组成*/
+ (BOOL)isNumberOrLetter:(NSString *)num;
/**检测是否是手机号码*/
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
/**判断字符串是否为空或者都是空格*/
+ (BOOL)isBlankString:(NSString *)string;

/**
 获取手机型号
 */
+ (NSString *)getPhoneVersion;


/**
 跳转到登录界面
 
 @param vc <#vc description#>
 */
+ (void)loginWithVC:(UIViewController *)vc;


/**
 保留两位小数

 @param num <#num description#>
 @return <#return value description#>
 */
+ (NSString *)getFloatStr:(CGFloat)num;

/**
 将字符串转换为保留精度的数字

 @param numStr <#numStr description#>
 @return <#return value description#>
 */
+ (CGFloat)getFloatNum:(NSString *)numStr;


/**
 获取当前的navcontroller
 
 @return <#return value description#>
 */
+ (UINavigationController *)getCurrentNavigationController;

/**
 获取当前tabbarvc
 
 @return <#return value description#>
 */
+ (UITabBarController *)getcurrentTabbarController;


/** 存储数据到指定路径 */
+ (BOOL)saveData:(id)data path:(NSString *)path;
/** 从指定路径读取数据 */
+ (id)readDataFromPath:(NSString *)path;


@end
