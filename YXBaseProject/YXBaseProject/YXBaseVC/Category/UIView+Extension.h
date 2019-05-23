//
//  UIView+Extension.h
//
//
///

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic) CGFloat top;                ///< Shortcut for frame.origin.y
@property (nonatomic, assign) CGFloat right;      ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic, assign) CGFloat bottom;     ///< Shortcut for frame.origin.y + frame.size.height


@end
