
//
//  ZCControl.m
//  Device
//
//  Created by ZhangCheng on 14-4-19.
//  Copyright (c) 2014年 zhangcheng. All rights reserved.
//

#import "MyControl.h"
#import "YXBaseVCHeader.h"
#define IOS7   [[UIDevice currentDevice]systemVersion].floatValue>=7.0
#define kHeight [[UIScreen mainScreen] bounds].size.height//获取屏幕高度，兼容性测试
#define kWidth [[UIScreen mainScreen] bounds].size.width//获取屏幕宽度，兼容性测试

@implementation MyControl

//+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(CGFloat)font Text:(NSString*)text color:(UIColor*)color textAlignment:(NSTextAlignment)textAlignment numberLines:(NSInteger)num
//{
//    UILabel *label = [[UILabel alloc] initWithFrame:frame];
//    if (font) {
//        label.font = [UIFont systemFontOfSize:font];
//    }
//    if (text) {
//        label.text = text;
//    }
//    if (color) {
//        label.textColor = color;
//    }
//    if (textAlignment){
//        label.textAlignment = textAlignment;
//    }
//    if (num >= 0) {
//        label.numberOfLines = num;
//    }
//    return label;
//}

+ (UILabel*)createLabelWithFrame:(CGRect)frame FontName:(UIFont *)font Text:(NSString*)text color:(UIColor*)color textAlignment:(NSTextAlignment)textAlignment numberLines:(NSInteger)num{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    if (font) {
        label.font = font;
    }
    if (text) {
        label.text = text;
    }
    if (color) {
        label.textColor = color;
    }
    if (textAlignment){
        label.textAlignment = textAlignment;
    }
    if (num >= 0) {
        label.numberOfLines = num;
    }
    return label;
}

+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(UIFont *)font Text:(NSString*)text
{
    UILabel*label=[[UILabel alloc]initWithFrame:frame];
    //限制行数
    label.numberOfLines=1;
    //对齐方式
    label.textAlignment=NSTextAlignmentLeft;
    label.backgroundColor=[UIColor clearColor];
    label.font=font;
    //单词折行
    label.lineBreakMode=NSLineBreakByWordWrapping;
    //默认字体颜色是白色
    label.textColor=[UIColor blackColor];
    //自适应（行数~字体大小按照设置大小进行设置）
//    label.adjustsFontSizeToFitWidth=YES;
    label.text=text;
    return label;
}

+(UIButton*)createButtonWithFrame:(CGRect)frame andImageName:(NSString*)imageName andTitle:(NSString*)title andFont:(UIFont *)font andColor:(UIColor *)color Target:(id)target Action:(SEL)action
{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    if (imageName) {
        
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (font) {
        button.titleLabel.font = font;
    }
    if (color) {
        [button setTitleColor:color forState:(UIControlStateNormal)];
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+ (UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title
{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.adjustsImageWhenHighlighted = NO;
    
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (imageName) {
        //设置背景图片，可以使文字与图片共存
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    //图片与文字如果需要同时存在，就需要图片足够小 详见人人项目按钮设置
    // [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
    
}


+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font textColor:(UIColor *)textColor target:(id)target action:(SEL)action{
    
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    if (title) {
        [button setTitle:title forState:(UIControlStateNormal)];
    }
    if (font) {
        button.titleLabel.font = font;
    }
    if (textColor) {
        [button setTitleColor:textColor forState:(UIControlStateNormal)];
    }
    if (action) {
        [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    }
    return button;
}

+ (UIButton *)createFooterViewBtnWithTitle:(NSString *)title font:(UIFont *)font textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor target:(id)target action:(SEL)action{
    UIButton *btn = [MyControl createButtonWithFrame:(CGRectZero) title:title font:font textColor:textColor target:target action:action];
    btn.layer.cornerRadius = 2;
    btn.layer.masksToBounds = YES;
    if (bgColor) {
        btn.backgroundColor = bgColor;
    }
    return btn;
}

+ (UIView*)createViewWithFrame:(CGRect)frame andBGColor:(UIColor *)color
{
    UIView *view=[[UIView alloc]initWithFrame:frame];
    if (color) {
        view.backgroundColor = color;
    }
    return view ;
}


+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(UIImage*)image
{
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:frame];
    imageView.image=image;
    imageView.layer.masksToBounds = YES;
    imageView.userInteractionEnabled=YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    return imageView ;
}

+ (UITextField *)crateTextFieldWithFrame:(CGRect)frame andPlaceHolder:(NSString *)placeHolder andFont:(CGFloat)font{
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.placeholder = placeHolder;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font=[UIFont systemFontOfSize:font];
    return textField;
}

+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font
{
    UITextField*textField = [[UITextField alloc]initWithFrame:frame];
    //灰色提示框
    textField.placeholder=placeholder;
    //文字对齐方式
    textField.textAlignment=NSTextAlignmentLeft;
    textField.secureTextEntry=YESorNO;
    //边框
    //textField.borderStyle=UITextBorderStyleLine;
    //键盘类型
    textField.keyboardType=UIKeyboardTypeEmailAddress;
    //关闭首字母大写
    textField.autocapitalizationType=NO;
    //清除按钮
    textField.clearButtonMode=YES;
    //左图片
    textField.leftView=imageView;
    textField.leftViewMode=UITextFieldViewModeAlways;
    //右图片
    textField.rightView=rightImageView;
    //编辑状态下一直存在
    textField.rightViewMode=UITextFieldViewModeWhileEditing;
    //自定义键盘
    //textField.inputView
    //字体
    textField.font=[UIFont systemFontOfSize:font];
    //字体颜色
    textField.textColor=[UIColor blackColor];
    return textField ;
    
}





+ (UIBarButtonItem *)buttonWithTarget:(id)theTarget action:(SEL)theAction title:(NSString *)title left:(BOOL) isLeft
{
    UIButton *backButton = Nil;
    if (isLeft) {
        backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 50)];
        [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        //        [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateHighlighted];
    } else {
        backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    //    [backButton setTitle:title forState:UIControlStateNormal];
    //    [backButton setTitle:title forState:UIControlStateHighlighted];
    //    [backButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    //    [backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, -3)];
    
    [backButton addTarget:theTarget action:theAction forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*leftItem=[[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    return leftItem;
}


+(CGRect)createCGRectMakeScale:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height
{
    CGFloat autoSizeScaleX;
    CGFloat autoSizeScaleY;
    
    if(kScreenHeight > 480){
        autoSizeScaleX = kWidth/320;
        autoSizeScaleY = kHeight/568;
    }else{
        autoSizeScaleX = 1.0;
        autoSizeScaleY = 1.0;
    }
    
    CGRect rect;
    rect.origin.x = x * autoSizeScaleX;
    rect.origin.y = y * autoSizeScaleY;
    rect.size.width = width * autoSizeScaleX;
    rect.size.height = height * autoSizeScaleY;
    return rect;
}

+(CGPoint)createCGPointMakeScale:(CGFloat)x andY:(CGFloat)y
{
    CGFloat autoSizeScaleX;
    CGFloat autoSizeScaleY;
    
    if(kScreenHeight > 480){
        autoSizeScaleX = kWidth/320;
        autoSizeScaleY = kHeight/568;
    }else{
        autoSizeScaleX = 1.0;
        autoSizeScaleY = 1.0;
    }
    
    CGPoint point;
    point.x = x * autoSizeScaleX;
    point.y = y * autoSizeScaleY;
    return point;
}

+(CGSize)createCGSizeMakeScale:(CGFloat)width andHeight:(CGFloat)height
{
    CGFloat autoSizeScaleX;
    CGFloat autoSizeScaleY;
    
    if(kScreenHeight > 480){
        autoSizeScaleX = kWidth/320;
        autoSizeScaleY = kHeight/568;
    }else{
        autoSizeScaleX = 1.0;
        autoSizeScaleY = 1.0;
    }
    
    CGSize size;
    size.width = width * autoSizeScaleX;
    size.height = height * autoSizeScaleY;
    return size;
}

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





+(UIScrollView*)makeScrollViewWithFrame:(CGRect)frame andSize:(CGSize)size
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = size;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    return scrollView ;
}

+(UIScrollView *)createUIScrollViewWithFrame:(CGRect)frame contentSize:(CGSize)size pagingEnabled:(BOOL)pagingEnabled showsHorizontalScrollIndicator:(BOOL)showsHorizontalScrollIndicator showsVerticalScrollIndicator:(BOOL)showsVerticalScrollIndicator delegate:(id)delegate
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:frame];
    scrollView.contentSize = size;
    scrollView.pagingEnabled = pagingEnabled;
    scrollView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator;
    scrollView.showsVerticalScrollIndicator = showsVerticalScrollIndicator;
    if (delegate != nil) {
        scrollView.delegate = delegate;
    }
    return scrollView;
}

+(UIPageControl*)makePageControlWithFram:(CGRect)frame
{
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:frame];
    pageControl.numberOfPages = 2;
    pageControl.currentPage = 0;
    return pageControl;
}
+(UISlider*)makeSliderWithFrame:(CGRect)rect AndImage:(UIImage*)image
{
    UISlider *slider = [[UISlider alloc]initWithFrame:rect];
    slider.minimumValue = 0;
    slider.maximumValue = 1;
    [slider setThumbImage:[UIImage imageNamed:@"qiu"] forState:UIControlStateNormal];
    slider.maximumTrackTintColor = [UIColor grayColor];
    slider.minimumTrackTintColor = [UIColor yellowColor];
    slider.continuous = YES;
    slider.enabled = YES;
    return slider ;
}
+(NSString *)stringFromDateWithHourAndMinute:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

#pragma -mark 判断导航的高度
+(float)isIOS7{
    
    float height;
    if (IOS7) {
        height=64.0;
    }else{
        height=44;
    }
    return height;
}

#pragma mark 内涵图需要的方法
+ (NSString *)stringDateWithTimeInterval:(NSString *)timeInterval
{
    NSTimeInterval seconds = [timeInterval integerValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [format stringFromDate:date];
}

+ (CGFloat)textHeightWithString:(NSString *)text width:(CGFloat)width fontSize:(NSInteger)fontSize
{
    NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    // 根据第一个参数的文本内容，使用280*float最大值的大小，使用系统14号字，返回一个真实的frame size : (280*xxx)!!
    CGRect frame = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return frame.size.height + 5;
}

// 返回一个整数字符串加1后的新字符串
+ (NSString *)addOneByIntegerString:(NSString *)integerString
{
    NSInteger integer = [integerString integerValue];
    return [NSString stringWithFormat:@"%d",(int)(integer+1)];
}



@end
