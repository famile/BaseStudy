//
//  NavigationViewController.m
//  TSJ
//
//  Created by 李涛 on 15/8/19.
//  Copyright (c) 2015年 敲代码的小毛驴. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation NavigationViewController

//+ (void)initialize{
    //设置整个项目所有item的主题样式
    //    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
//    UINavigationBar *navBar = [UINavigationBar appearance];
////    navBar.barTintColor = [UIColor clearColor];
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    dic[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    dic[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    [navBar setTitleTextAttributes:dic];
//    
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
////    [[UINavigationBar appearance] setTintColor:[UIColor clearColor]];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    

}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.viewControllers.count != 1) {
            return YES;
        }else
            return NO;
    }
    return YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count>0) {
        //这时候push进来的控制器不是第一个子控制器
        /**
         *  自动显示和隐藏tabbar
         */
    viewController.hidesBottomBarWhenPushed = YES;
    viewController.navigationItem.leftBarButtonItems = [self itemWithTarget:self action:@selector(back) image:@"fanhui-45_02" highImage:@"fanhui-45_02"];
    }
    [super pushViewController:viewController animated:animated];
}
- (void)back{
    [self popViewControllerAnimated:YES];
}

//- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
//    UIViewController *vc = [super popViewControllerAnimated:animated];
//    if (self.viewControllers.count == 1) {
//        self.tabBarController.tabBar.hidden = NO;
//    }
//    return vc;
//}

- (NSArray *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
   
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIBarButtonItem *fixItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixItem.width = -10;
    
    return @[fixItem,leftItem];
}

@end
