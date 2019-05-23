//
//  PopScaleButton.m
//  PopStudyDemo
//
//  Created by 李涛 on 2017/5/8.
//  Copyright © 2017年 Tao_Lee. All rights reserved.
//

#import "PopScaleButton.h"
#import <POP/POP.h>

@interface PopScaleButton ()
- (void)setup;
- (void)scaleToSmall;
- (void)scaleAniamtion;
- (void)scaleToDefault;

@end

@implementation PopScaleButton

+ (instancetype)button{
    return [self buttonWithType:UIButtonTypeCustom];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Instance methods
//- (UIEdgeInsets)titleEdgeInsets
//{
//    return UIEdgeInsetsMake(4.f,
//                            28.f,
//                            4.f,
//                            28.f);
//}

//- (CGSize)intrinsicContentSize
//{
//    CGSize s = [super intrinsicContentSize];
//    
//    return CGSizeMake(s.width + self.titleEdgeInsets.left + self.titleEdgeInsets.right,
//                      s.height + self.titleEdgeInsets.top + self.titleEdgeInsets.bottom);
//    
//}

#pragma mark - Private instance methods

- (void)setup
{
    [self addTarget:self action:@selector(scaleToSmall)
   forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [self addTarget:self action:@selector(scaleAnimation)
   forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(scaleToDefault)
   forControlEvents:UIControlEventTouchDragExit];
}

- (void)scaleToSmall
{
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.95f, 0.95f)];
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSmallAnimation"];
}

- (void)scaleAnimation
{
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(3.f, 3.f)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scaleAnimation.springBounciness = 18.0f;
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSpringAnimation"];
}

- (void)scaleToDefault
{
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleDefaultAnimation"];
}


@end
