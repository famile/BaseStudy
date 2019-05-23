//
//  ViewController.m
//  CalendarStudyDemo
//
//  Created by 李涛 on 2017/6/2.
//  Copyright © 2017年 Tao_Lee. All rights reserved.
//

#import "ViewController.h"
#import "FSCalendar.h"

@interface ViewController ()<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>
@property (nonatomic, strong) FSCalendar *calendar;

@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@property (strong, nonatomic) NSDate *minimumDate;
@property (strong, nonatomic) NSDate *maximumDate;

@property (nonatomic, strong) NSMutableArray *notSelectArr;

@end

@implementation ViewController

- (void)loadView{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    self.view = view;
    
#define FULL_SCREEN 1
    
#if FULL_SCREEN
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:[UIScreen mainScreen].bounds];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.pagingEnabled = NO;
    calendar.allowsMultipleSelection = NO;
    calendar.firstWeekday = 1;
    calendar.placeholderType = FSCalendarPlaceholderTypeNone;
    calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase | FSCalendarCaseOptionsHeaderUsesUpperCase;
    calendar.today = nil;
//    calendar.weekdayHeight = 0;
    
    
    [self.view addSubview:calendar];
    self.calendar = calendar;
    
#else
    
#endif
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    
//    self.minimumDate = [self.dateFormatter dateFromString:@"2017-01-01"];
    self.minimumDate = [NSDate date];
    self.maximumDate = [self.dateFormatter dateFromString:@"2017-08-31"];
    
    [self.notSelectArr addObject:@"2017-06-06"];
    
    self.calendar.accessibilityIdentifier = @"calender";
    
}

#pragma mark - FSCalendarDataSource

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar{
    return self.minimumDate;
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar{
    return self.maximumDate;
}

#pragma mark - FSCalendarDelegate

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    return [self showldSelectDate:date];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    NSLog(@"did select %@",[self.dateFormatter stringFromDate:date]);
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar{
    NSLog(@"did change page %@",[self.dateFormatter stringFromDate:calendar.currentPage]);;
}

#pragma mark - FSCalendarDelegateAppearance
- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderDefaultColorForDate:(NSDate *)date{
    if ([@"2017-06-05" isEqualToString:[self.dateFormatter stringFromDate:date]]) {
        return [UIColor blueColor];
    }
    return [UIColor clearColor];
}




//- (CGFloat)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderRadiusForDate:(NSDate *)date{
//    if ([calendar.today isEqualToDate:[NSDate date]]) {
//        return 1.0;
//    }
//    
//    return 0.0;
//}

#pragma mark - httpRequest

#pragma mark - click

#pragma mark - init


- (BOOL)showldSelectDate:(NSDate *)date{
    NSString *dateStr = [self.dateFormatter stringFromDate:date];
    if ([self.notSelectArr containsObject:dateStr]) {
        return NO;
    }
    return YES;
}

- (NSMutableArray *)notSelectArr{
    if (!_notSelectArr) {
        _notSelectArr = [NSMutableArray array];
    }
    return _notSelectArr;
}

@end
