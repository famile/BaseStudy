//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyControl : NSObject

#pragma mark - 创建Label
/**
 创建Label（自定义frame，font，text，color，alignment，lines）
 */
//+ (UILabel*)createLabelWithFrame:(CGRect)frame Font:(CGFloat)font Text:(NSString*)text color:(UIColor*)color textAlignment:(NSTextAlignment)textAlignment numberLines:(NSInteger)num;

+ (UILabel*)createLabelWithFrame:(CGRect)frame FontName:(UIFont *)font Text:(NSString*)text color:(UIColor*)color textAlignment:(NSTextAlignment)textAlignment numberLines:(NSInteger)num;

/**
 创建label（frame font text）

 @param frame frame
 @param font font
 @param text text
 @return label
 */
+ (UILabel*)createLabelWithFrame:(CGRect)frame Font:(UIFont *)font Text:(NSString*)text;


#pragma mark - 创建button

/**
 创建常用button

 @param frame <#frame description#>
 @param imageName <#imageName description#>
 @param title <#title description#>
 @param size <#size description#>
 @param color <#color description#>
 @param target <#target description#>
 @param action <#action description#>
 @return <#return value description#>
 */
+(UIButton*)createButtonWithFrame:(CGRect)frame andImageName:(NSString*)imageName andTitle:(NSString*)title andFont:(UIFont *)font andColor:(UIColor *)color Target:(id)target Action:(SEL)action;

+(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title;

/**
 创建纯文字的btn
 */
+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font textColor:(UIColor *)textColor target:(id)target action:(SEL)action;

+ (UIButton *)createFooterViewBtnWithTitle:(NSString *)title font:(UIFont *)font textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor target:(id)target action:(SEL)action;


#pragma mark - 创建View
+ (UIView*)createViewWithFrame:(CGRect)frame andBGColor:(UIColor *)color;

#pragma mark - 创建imageView
+ (UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(UIImage*)image;

#pragma mark - 创建UITextField

/**
 创建圆角的textfield

 @param frame <#frame description#>
 @param placeHolder <#placeHolder description#>
 @param font <#font description#>
 @return <#return value description#>
 */
+ (UITextField *)crateTextFieldWithFrame:(CGRect)frame andPlaceHolder:(NSString *)placeHolder andFont:(CGFloat)font;

/**
 创建带图片的textfield

 @param frame <#frame description#>
 @param placeholder <#placeholder description#>
 @param YESorNO <#YESorNO description#>
 @param imageView <#imageView description#>
 @param rightImageView <#rightImageView description#>
 @param font <#font description#>
 @return <#return value description#>
 */
+ (UITextField *)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font;









+ (UIBarButtonItem *)buttonWithTarget:(id)theTarget action:(SEL)theAction title:(NSString *)title left:(BOOL) isLeft;


//屏幕适配等比放大
+(CGRect)createCGRectMakeScale:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height;
+(CGPoint)createCGPointMakeScale:(CGFloat)x andY:(CGFloat)y;
+(CGSize)createCGSizeMakeScale:(CGFloat)width andHeight:(CGFloat)height;

#pragma mark --创建数据模型
+(void)createModelFromDictionary:(NSDictionary *)dict className:(NSString *)className;

#pragma mark 创建UIScrollView
+(UIScrollView*)makeScrollViewWithFrame:(CGRect)frame andSize:(CGSize)size;
+(UIScrollView *)createUIScrollViewWithFrame:(CGRect)frame contentSize:(CGSize)size pagingEnabled:(BOOL)pagingEnabled showsHorizontalScrollIndicator:(BOOL)showsHorizontalScrollIndicator showsVerticalScrollIndicator:(BOOL)showsVerticalScrollIndicator delegate:(id)delegate;
#pragma mark 创建UIPageControl
+(UIPageControl*)makePageControlWithFram:(CGRect)frame;
#pragma mark 创建UISlider
+(UISlider*)makeSliderWithFrame:(CGRect)rect AndImage:(UIImage*)image;
#pragma mark 创建时间转换字符串
+(NSString *)stringFromDateWithHourAndMinute:(NSDate *)date;
#pragma mark --判断导航的高度64or44
+(float)isIOS7;

#pragma mark 内涵图需要的方法
+ (NSString *)stringDateWithTimeInterval:(NSString *)timeInterval;

+ (CGFloat)textHeightWithString:(NSString *)text width:(CGFloat)width fontSize:(NSInteger)fontSize;

+ (NSString *)addOneByIntegerString:(NSString *)integerString;


@end
