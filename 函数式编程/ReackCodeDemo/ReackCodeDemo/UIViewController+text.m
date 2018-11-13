//
//  UIViewController+text.m
//  ReackCodeDemo
//
//  Created by 李涛 on 2018/7/2.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

#import "UIViewController+text.h"
#import <objc/runtime.h>
@interface UIViewController()



@end

@implementation UIViewController (text)


- (void)setName:(NSString *)name{
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name{
    return objc_getAssociatedObject(self, @selector(name));
}


@end
