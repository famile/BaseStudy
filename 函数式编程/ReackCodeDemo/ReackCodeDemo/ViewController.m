//
//  ViewController.m
//  ReackCodeDemo
//
//  Created by 李涛 on 2018/6/28.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"



@interface ViewController ()<MyProtocol>

@property (nonatomic, copy) NSString *str1;
@property (nonatomic, getter=p_str2, copy) NSString *str2;


@property (nonatomic, strong) NSArray *arr;

@end

@implementation ViewController

//@dynamic myProperty;

@synthesize myProperty = _myProperty;

@synthesize str1 = _str3;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Person *p = [[Person alloc] init];
//    [p eat1];
//    [p sleep1];
//    
//    [[p sleep2] eat2];
//    [[p eat2] sleep2];
//    
//    p.eat3();
//    p.sleep3();
    
    p.eat4().sleep4();
    p.sleep4().eat4();
    
    p.eat5(@"水果").sleep5(8);
    p.sleep5(6).eat5(@"香蕉");
    
    
    _str3 = @"hehe1";
    _str2 = _str3;
    NSLog(@"str1->%@,str2->%@",_str3,_str2);
    _str3 = @"hehe2";
    NSLog(@"str1->%@,str2->%@",_str3,_str2);
    
    _myProperty = @"haha";
    NSLog(@"self.myProperty->%@",self.myProperty);
    
    [self p_str2];
    
    NSArray *arr1 = @[@"1",@"2",@"3"];
    NSMutableArray *arr2 = [NSMutableArray arrayWithArray:arr1];
    _arr = arr2;
    [arr2 removeAllObjects];
    NSLog(@"%@",_arr);
    
    arr2 = [NSMutableArray arrayWithArray:arr1];
    _arr = [arr2 copy];
    [arr2 removeAllObjects];
    NSLog(@"%@",_arr);
    
}


//- (NSString *)p_str2{
//    return _str2;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
