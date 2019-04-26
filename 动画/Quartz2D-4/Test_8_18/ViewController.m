//
//  ViewController.m
//  Test_8_18
//
//  Created by 李涛 on 15/8/18.
//  Copyright (c) 2015年 敲代码的小毛驴. All rights reserved.
//

#import "ViewController.h"
#import "CropView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CropView *view = [[CropView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
