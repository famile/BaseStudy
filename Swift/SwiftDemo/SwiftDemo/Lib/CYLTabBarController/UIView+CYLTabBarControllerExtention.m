//
//  CYLTabBarController.m
//  CYLTabBarController
//
//  v1.12.0 Created by 微博@iOS程序犭袁 ( http://weibo.com/luohanchenyilong/ ) on 10/20/15.
//  Copyright © 2015 https://github.com/ChenYilong . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+CYLTabBarControllerExtention.h"
#import "CYLPlusButton.h"

@implementation UIView (CYLTabBarControllerExtention)

- (BOOL)cyl_isPlusButton {
    return [self isKindOfClass:[CYLExternPlusButton class]];
}

- (BOOL)cyl_isTabButton {
    BOOL isKindOfButton = [self cyl_isKindOfClass:[UIControl class]];
    return isKindOfButton;
}

- (BOOL)cyl_isTabImageView {
    BOOL isKindOfImageView = [self cyl_isKindOfClass:[UIImageView class]];
    if (!isKindOfImageView) {
        return NO;
    }
    NSString *subString = [NSString stringWithFormat:@"%@cat%@ew", @"Indi" , @"orVi"];
    BOOL isBackgroundImage = [self cyl_classStringContainsString:subString];
    BOOL isTabImageView = !isBackgroundImage;
    return isTabImageView;
}

- (BOOL)cyl_isTabLabel {
    BOOL isKindOfLabel = [self cyl_isKindOfClass:[UILabel class]];
    return isKindOfLabel;
}

- (BOOL)cyl_isKindOfClass:(Class)class {
    BOOL isKindOfClass = [self isKindOfClass:class];
    BOOL isClass = [self isMemberOfClass:class];
    BOOL isKind = isKindOfClass && !isClass;
    if (!isKind) {
        return NO;
    }
    BOOL isTabBarClass = [self cyl_isTabBarClass];
    return isTabBarClass;
}

- (BOOL)cyl_isTabBarClass {
    NSString *tabBarClassString = [NSString stringWithFormat:@"U%@a%@ar", @"IT" , @"bB"];
    BOOL isTabBarClass = [self cyl_classStringContainsString:tabBarClassString];
    return isTabBarClass;
}

- (BOOL)cyl_classStringContainsString:(NSString *)subString {
    NSString *classString = NSStringFromClass([self class]);
    if ([classString rangeOfString:subString].location == NSNotFound) {
        return NO;
    }
    return YES;
}

@end
