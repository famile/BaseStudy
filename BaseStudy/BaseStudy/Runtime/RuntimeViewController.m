//
//  RuntimeViewController.m
//  BaseStudy
//
//  Created by 李涛 on 2018/11/13.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

#import "RuntimeViewController.h"

#import "UIImage+DownloadURL.h"

@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *img = [[UIImage alloc] init];
    img.downLoadURL = @"1324";
    NSLog(@"%@",img.downLoadURL);
}


#pragma mark - httpRequest

#pragma mark - click

#pragma mark - private method

#pragma mark - setter

#pragma mark - init


@end
