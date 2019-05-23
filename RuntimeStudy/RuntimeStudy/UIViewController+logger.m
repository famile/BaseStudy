//
//  UIViewController+logger.m
//  RuntimeStudy
//
//  Created by 李涛 on 2019/5/16.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "UIViewController+logger.h"
#import "XZDHook.h"
@implementation UIViewController (logger)
+ (void)initialize{
    
}

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL fromSelectorAppear = @selector(viewWillAppear:);
        SEL toSelectorAppear = @selector(hook_viewWillAppear:);
        [XZDHook hookClass:[self class] fromSelector:fromSelectorAppear toSelector:toSelectorAppear];
        
        SEL fromSelectorDisappear = @selector(viewWillDisappear:);
        SEL toSelectorDisappear = @selector(hook_viewWillDisappear:);
        [XZDHook hookClass:[self class] fromSelector:fromSelectorDisappear toSelector:toSelectorDisappear];
    });
}

- (void)hook_viewWillAppear:(BOOL)animated{
    //先执行插入代码，再执行原viewWillAppear方法
//    [self insertToViewWillAppear];
    [self hook_viewWillAppear:animated];
    NSLog(@"%@开始插入埋点",[self class]);
}

- (void)hook_viewWillDisappear:(BOOL)animated{
    //执行插入代码，再执行原viewWillDisappear
//    [self insertToViewWillDisappear];
    [self hook_viewWillDisappear:animated];
    
}


- (void)insertToViewWillAppear{
    NSLog(@"%@开始插入埋点",[self class]);
}

- (void)insertToViewWillDisappear{
    NSLog(@"%@结束插入埋点",[self class]);
}

@end
