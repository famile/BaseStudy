//
//  ViewController.m
//  EffectiveObject-CStudy
//
//  Created by 李涛 on 2017/5/18.
//  Copyright © 2017年 Tao_Lee. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

NSString *const ViewControllerNotification = @"132";
static const NSTimeInterval kAnimationDuration = 0.3f;

static const NSString * ViewControllerName = @"VC";

typedef enum : NSUInteger {
    EnumA,
    EnumB,
} Enums;



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor redColor];
    
    
    NSLog(@"%@,%.2f",ViewControllerNotification,kAnimationDuration);
    Enums chara = EnumA;
    switch (chara) {
        case EnumA:
            
            break;
        case EnumB:
            
            break;
            
    }
    
    NSString *string = @"This iS the sTring";
    
    NSLog(@"lowercaseString = %@",[string lowercaseString]);
    NSLog(@"uppercaseString = %@",[string uppercaseString]);
    
    Method originalMethod = class_getInstanceMethod([NSString class], @selector(lowercaseString));
    Method swappedMethod = class_getInstanceMethod([NSString class], @selector(uppercaseString));
    
    method_exchangeImplementations(originalMethod, swappedMethod);
    
    NSLog(@"new_lowercaseString = %@",[string lowercaseString]);
    NSLog(@"new_uppercaseString = %@",[string uppercaseString]);
    
    
    [self copyTest];
    
}


- (void)copyTest{
    NSMutableString *value = [NSMutableString stringWithFormat:@"value"];
    NSDictionary *dic = @{@"key":value};
    NSLog(@"old -> %@",dic);
    [value appendString:@"2"];
    NSLog(@"new -> %@",dic);
    NSLog(@"value -> %@",value);
    
    NSMutableArray *arr1 = @[@"old"].mutableCopy;
    NSDictionary *dic2 = @{@"key":arr1};
    NSLog(@"old -> %@",dic2);
    [arr1 addObject:@"new"];
    NSLog(@"new -> %@",dic2);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
