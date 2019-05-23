//
//  UIViewController+Swizzling.m
//  BaseStudy
//
//  Created by 李涛 on 2018/11/13.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import "NSObject+Swizzling.h"

@implementation UIViewController (Swizzling)

/*
 load 和 initialize区别
 
 load:当类被引用进项目的时候就会执行load（在main函数执行之前）方法，与这个类是否被用到无关，每个类的load函数只会调用一次，由于load函数是自动加载的，因此不需要调用父类的load方法，
 1、当父类和子类都实现load函数时，父类的load方法执行顺序要优于子类
 2、当子类未实现load方法时，不会调用父类方法？？？？？（实际是会调用的）
 3、类中的load方法执行顺序要优先于类别（Category）
 4、当有多个类别都实现了load方法，这几个load方法都会执行，但执行顺序不确定
 5、当然当有多个不同的类的时候,每个类load 执行顺序与其在Compile Sources出现的顺序一致
 
 initialize:在类或者其子类的第一个方法被调用前调用，即时类文件被引用，但是没有被使用，initialize也不会被调用，
 1、父类的initialize会比子类先执行
 2.当子类未实现initialize方法时，会调用父类initialize方法，子类实现initialize方法时，会覆盖父类方法
 3、当有多个category都实现了initialize方法，会覆盖类中的方法，只执行Compile Sources 列表中最后一个Category中的方法
 
 */

//+ (void)load{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [UIViewController methodSwizzlingWithOriginalSelector:@selector(viewDidAppear:) bySwizzledSelector:@selector(lt_viewDidAppear:)];
//    });
//}
//
//- (void)lt_viewDidAppear:(BOOL)animated{
//    [self lt_viewDidAppear:animated];
//    NSLog(@"===== %@ viewDidAppear ====",[self class]);
//}


@end
