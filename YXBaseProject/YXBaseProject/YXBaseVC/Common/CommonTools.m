//
//  CommonTool.m
//  qianxiheiOS
//
//  Created by ZSC on 15/6/11.
//  Copyright (c) 2015年 qxhiOS. All rights reserved.
//

#import "CommonTools.h"
#import "CommonCrypto/CommonDigest.h"
#import <sys/utsname.h>
#import "AppDelegate.h"
#import "YXBaseVCHeader.h"


#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface CommonTools ()

@end

@implementation CommonTools

+ (void)showAlertWithMainTitle:(NSString *)mainTitle
             andSecondaryTitle:(NSString *)secondaryTitle
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:mainTitle message:secondaryTitle delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
    [alert show];
}
+ (void)showAlertWithMoreTitle:(NSString *)mainTitle andMessageTitle:(NSString *)messageTitle{

    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:mainTitle message:messageTitle delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];

    [alert show];
}

+ (void)openAppaleShopWithAppleID:(NSString *)appleID
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",appleID];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    } else {
        NSString *str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", appleID];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }

}

+ (NSString *)getAmountOfMoneyWithPercentMoney:(NSString *)money{
    if ([CommonTools isBlankString:money]) {
        return @"";
    }
    NSDecimalNumber *finalMoney = [[NSDecimalNumber decimalNumberWithString:money] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
    return [finalMoney stringValue];
}

//获取字符串宽度
+ (CGFloat)getZSCTextWidth:(NSString *)textStr andTextFont:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName : font};
    CGSize size = [textStr boundingRectWithSize:CGSizeMake(0, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return size.width;
}


+ (CGFloat)getZSCTextHight:(NSString *)textStr andWidth:(CGFloat)width andTextFont:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize size = [textStr boundingRectWithSize:CGSizeMake(width, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return size.height;
}

//获取时间戳(秒)
+ (NSTimeInterval)timeSp
{
    NSDate *datenow = [NSDate date];
    return [datenow timeIntervalSince1970];
}

+ (NSString*)getCurrentTimestamp
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];
    NSString * timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}

//获取时间间隔
+ (NSString *)timeInterval:(NSString *)timeSp
{
    if (timeSp.length == 13)//毫秒转化为秒
    {
        //截取前10位
        timeSp = [timeSp substringToIndex:10];
    }
    
    NSDate *datenow = [NSDate date];
    NSString *currentTimeSp = [NSString stringWithFormat:@"%d", (int)[datenow timeIntervalSince1970]];
    //2个时间戳之间的差值(当前减过去)
    NSTimeInterval timeInterval = currentTimeSp.integerValue - timeSp.integerValue;
    
    if (timeInterval < 60) {
        return @"1分钟内";
    } else if (timeInterval < 3600) {
        return [NSString stringWithFormat:@"%.f分钟前", timeInterval / 60];
    } else if (timeInterval < 86400) {
        return [NSString stringWithFormat:@"%.f小时前", timeInterval / 3600];
    } else if (timeInterval < 2592000) {//30天内
        return [NSString stringWithFormat:@"%.f天前", timeInterval / 86400];
    } else if (timeInterval < 31536000) {//30天至1年内
        double lastactivityInterval = timeSp.floatValue;
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        //[formatter setDateFormat:@"MM月dd日 HH:mm"];
        [formatter setDateFormat:@"M月d日"];
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:lastactivityInterval];
        NSString* dateString = [formatter stringFromDate:date];
        return dateString;
    } else {
        return [NSString stringWithFormat:@"%.f年前", timeInterval / 31536000];
    }
}

//获取当前时间
+ (NSString *)currentTime
{
    // <1>获取当前时间
    //细节: 获取的是国际标准时(与中国时间相差8小时)
    NSDate *date = [NSDate date];
    // <2>获取本地时间,格式化时间
    //NSDateFormatter功能是格式化时间
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //设置了时间的格式---格式由文档规定的
    [df setDateFormat:@"yyyy-MM-dd"];
    return [df stringFromDate:date];
}

+ (NSString *)tomorrowDate{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:24 * 60 * 60];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //设置了时间的格式---格式由文档规定的
    [df setDateFormat:@"yyyy-MM-dd"];
    return [df stringFromDate:date];
}

//  将请求获取的时间改成标准时间
+ (NSString *)standardTime:(NSNumber *)numTime
{
    
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    NSString *tmpTime = [numberFormatter stringFromNumber:numTime];
    
    if (tmpTime.length == 13)
    {
        tmpTime = [tmpTime substringToIndex:10];
    }
    double lastactivityInterval = [tmpTime floatValue];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:lastactivityInterval];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSDate *)dateWithTimeSp:(NSInteger)timeSp{
    timeSp = timeSp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeSp];
    return date;
}

+ (NSString *)timeStrWithTimeSp:(NSInteger)timeSp{
    timeSp = timeSp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeSp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    formatter.dateFormat = @"HH:mm:ss";
    return [formatter stringFromDate:date];
}

+ (NSString *)dateStrWithTimeSp:(NSInteger)timeSp style:(NSString *)style{
    timeSp = timeSp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeSp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (style && style.length > 0) {
        formatter.dateFormat = style;
    }else{
        formatter.dateFormat = @"yyyy-MM-dd";
    }
    
    return [formatter stringFromDate:date];
}

+ (NSString *)dateStrWithDate:(NSDate *)date style:(NSString *)style{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (style && style.length > 0) {
        formatter.dateFormat = style;
    }else{
        formatter.dateFormat = @"yyyy-MM-dd";
    }
    
    return [formatter stringFromDate:date];
}

+ (NSInteger)timeSpWithDate:(NSDate *)date{
    
    return [date timeIntervalSince1970];
}

/**
 *  创建数据模型
 *
 *  @param dict      创建模型的依据字典
 *  @param className 模型名（可以设为空）
 */
+(void)createModelFromDictionary:(NSDictionary *)dict className:(NSString *)className
{
    //创建数据模型
    printf("@interface  %s : NSObject\n",className.UTF8String);
    for (NSString *key in dict)
    {
        printf("@property (copy,nonatomic) NSString *%s;\n",key.UTF8String);
    }
    printf("@end\n");
}

#pragma mark-改变控件高度Scroller
+ (void)setContentSize:(UIScrollView *)view andHight:(CGFloat)hight
{
    CGSize tempSize = view.contentSize;
    tempSize.height = hight;
    view.contentSize = tempSize;
}


#pragma mark -md5加密

+(NSString *)md5Encryption:(NSString *)inPutString
{
    const char *cStr = [inPutString UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}


+ (UIImage*)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+ (NSString *)getSystemVersion{
    NSString *systemName = [UIDevice currentDevice].systemName;
//    DLog(@"当前系统名称-->%@", systemName);
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
//    DLog(@"当前系统版本号-->%@", systemVersion);
    return systemVersion;
}
+ (NSString *)getAppVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"app版本号-->%@", app_Version);
    // app名称
//    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app build版本
//    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    return app_Version;
}

+ (NSString *)getBuildVersion{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    return app_build;
}

//检测字符串是否是纯数字
+ (BOOL)isNumber:(NSString *)num
{
    NSString *number = @"0123456789";
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:number] invertedSet];
    NSString *filtered = [[num componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [num isEqualToString:filtered];
    return basic;
}

//检测字符串是否是数字或字母组成
+ (BOOL)isNumberOrLetter:(NSString *)num
{
    NSString *numberOrLetter = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:numberOrLetter] invertedSet];
    NSString *filtered = [[num componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [num isEqualToString:filtered];
    return basic;
}

//检测是否是手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString * mobile = @"^1[0-9]\\d{9}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    if ([regextestmobile evaluateWithObject:mobileNum] == YES) {
        return YES;
    }else {
        return NO;
    }
}

//判断字符串是否为空或者都是空格
+ (BOOL)isBlankString:(NSString *)string
{
    if (string == nil){
        return YES;
    }
    if (string == NULL){
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]){
        return YES;
    }
    //判断字符串是否全部为空格（[NSCharacterSet whitespaceAndNewlineCharacterSet]去掉字符串两端的空格)
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0){
        return YES;
    }
    return NO;
}


+ (NSString *)getPhoneVersion{
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}

+ (void)loginWithVC:(UIViewController *)vc{
    
//    [vc.navigationController pushViewController:[[YXLoginViewController alloc] init] animated:YES];
}


+ (NSString *)getFloatStr:(CGFloat)num{
    /*
     roundingMode	四舍五入模式，有四个值： NSRoundUp, NSRoundDown, NSRoundPlain, and NSRoundBankers
     scale	结果保留几位小数
     raiseOnExactness	发生精确错误时是否抛出异常，一般为NO
     raiseOnOverflow	发生溢出错误时是否抛出异常，一般为NO
     raiseOnUnderflow	发生不足错误时是否抛出异常，一般为NO
     raiseOnDivideByZero	被0除时是否抛出异常，一般为YES
     
     */
    
    
    NSDecimalNumberHandler *handle = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    
    
    NSDecimalNumber *decimalNum = [[NSDecimalNumber alloc] initWithFloat:num];

    
    NSDecimalNumber *finalNum = [decimalNum decimalNumberByRoundingAccordingToBehavior:handle];
    return [NSString stringWithFormat:@"%@",finalNum];
}

+ (CGFloat)getFloatNum:(NSString *)numStr{
    NSDecimalNumberHandler *handle = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    
    
//    NSDecimalNumber *decimalNum = [[NSDecimalNumber alloc] initWithFloat:num];
    NSDecimalNumber *decimalNum = [[NSDecimalNumber alloc] initWithString:numStr];
    
    NSDecimalNumber *finalNum = [decimalNum decimalNumberByRoundingAccordingToBehavior:handle];
    return [finalNum floatValue];
}

+ (UINavigationController *)getCurrentNavigationController{
    if ([[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    }else{
        UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        return tab.selectedViewController;
    }
}

+ (UITabBarController *)getcurrentTabbarController{
    UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    return tab;
}


/** 存储数据到指定路径 */
+ (BOOL)saveData:(id)data path:(NSString *)path{
    return [NSKeyedArchiver archiveRootObject:data toFile:path];
}
/** 从指定路径读取数据 */
+ (id)readDataFromPath:(NSString *)path{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}


@end
