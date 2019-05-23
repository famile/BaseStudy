//
//  UIButton+logger.m
//  RuntimeStudy
//
//  Created by 李涛 on 2019/5/17.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "UIButton+logger.h"
#import "XZDHook.h"
@implementation UIButton (logger)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL fromSelector = @selector(sendAction:to:forEvent:);
        SEL toSelector = @selector(hook_sendAction:to:forEvent:);
        [XZDHook hookClass:self fromSelector:fromSelector toSelector:toSelector];
    });
}

- (void)hook_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    [self insertToSendAction:action to:target forEvent:event];
    [self hook_sendAction:action to:target forEvent:event];
}

- (void)insertToSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if ([[[event allTouches] anyObject] phase] == UITouchPhaseEnded) {
        NSString *actionString = NSStringFromSelector(action);
        NSString *targetName = NSStringFromClass([target class]);
        NSLog(@"action->%@,target->%@",actionString,targetName);
    }
}


@end
