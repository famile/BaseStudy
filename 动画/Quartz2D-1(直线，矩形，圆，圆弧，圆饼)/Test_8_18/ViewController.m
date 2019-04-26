//
//  ViewController.m
//  Test_8_18
//
//  Created by 李涛 on 15/8/18.
//  Copyright (c) 2015年 敲代码的小毛驴. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CustomView *cusView = [[CustomView alloc] initWithFrame:self.view.bounds];
    cusView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cusView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    
}

@end
