//
//  SecondViewController.m
//  EffectiveObject-CStudy
//
//  Created by 李涛 on 2017/5/18.
//  Copyright © 2017年 Tao_Lee. All rights reserved.
//

#import "SecondViewController.h"

//NSString *const SecondVCDidLoginNotification = @"1111";
static const NSString * ViewControllerName = @"VC";


@interface SecondViewController ()

@property (nonatomic, copy) NSString *SecondVCDidLoginNotification;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _SecondVCDidLoginNotification = @"1234";
    NSLog(@"%@",_SecondVCDidLoginNotification);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
