//
//  CustomLayerView.m
//  Test_8_18
//
//  Created by 李涛 on 16/3/7.
//  Copyright © 2016年 敲代码的小毛驴. All rights reserved.
//

#import "CustomLayerView.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_DEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define MIN_HEIGHT          100
@interface CustomLayerView ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) CGFloat curveX;//r5的x坐标
@property (nonatomic, assign) CGFloat curveY;//r5的y坐标
@property (nonatomic, strong) UIView *curveView;
@property (nonatomic, assign) CGFloat mHeight;//手势移动时的相对高度
@property (nonatomic, assign) BOOL isAnimating;//是否处于动效状态
@property (nonatomic, strong) CADisplayLink *displayLink;


@end

@implementation CustomLayerView

static NSString *kX = @"curveX";
static NSString *kY = @"curveY";

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addObserver:self forKeyPath:@"curveX" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"curveY" options:NSKeyValueObservingOptionNew context:nil];
        [self configShapeLayer];
        [self configCurveView];
        [self configAction];

        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kX] || [keyPath isEqualToString:kY]) {
        [self updateShapeLayerPath];
    }
}

- (void)configShapeLayer{
    
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.fillColor = [UIColor colorWithRed:57/255.0 green:67/255.0 blue:89/255.0 alpha:1.0].CGColor;
    [self.layer addSublayer:_shapeLayer];
}

- (void)configCurveView{
    self.curveX = SCREEN_WIDTH/2.0;
    self.curveY = MIN_HEIGHT;
    _curveView = [[UIView alloc] initWithFrame:CGRectMake(_curveX, _curveY, 3, 3)];
    _curveView.backgroundColor = [UIColor redColor];
    [self addSubview:_curveView];
}

- (void)configAction{
    
    _mHeight = 100;
    _isAnimating = NO;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanAction:)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:pan];
    
    //CADisplayLink默认每秒运行60次  calculatePath方法是算出在运行期间_curveView的坐标，从而确定_shapeLayer的形状
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(calculatePath)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    //在手势结束的时候才调用calculatePath方法，所以一开始是暂停的
    _displayLink.paused = YES;
}

- (void)handlePanAction:(UIPanGestureRecognizer *)pan{
    
    if (!_isAnimating)
    {
        if (pan.state == UIGestureRecognizerStateChanged) {
            
            //手势移动时，_shapeLayer跟着手势向下扩大区域
            CGPoint point = [pan translationInView:self];
            
            //这部分代码是r5红点跟着手势走
            _mHeight = point.y * 0.7 + MIN_HEIGHT;
            self.curveX = SCREEN_WIDTH/2 + point.x;
            self.curveY = _mHeight > MIN_HEIGHT ? _mHeight : MIN_HEIGHT;
            
            _curveView.frame = CGRectMake(_curveX,
                                          _curveY,
                                          _curveView.width,
                                          _curveView.height);
            
            //根据r5的坐标，更新_shapeLayer形状
//            [self updateShapeLayerPath];
            
        }else if(pan.state == UIGestureRecognizerStateCancelled ||
                 pan.state == UIGestureRecognizerStateFailed ||
                 pan.state == UIGestureRecognizerStateEnded){
            
            //手势结束时，_shapeLayer返回原状态并产生弹簧动效
            _isAnimating = YES;
            
            //开启displayLink 会执行方法calculatePath
            _displayLink.paused = NO;
            
            //弹簧动效
            [UIView animateWithDuration:1.0
                                  delay:0.0
                 usingSpringWithDamping:0.5
                  initialSpringVelocity:0
                                options:UIViewAnimationOptionCurveEaseInOut animations:^{
                //曲线点是一个view，所以在block中有弹簧效果，然后根据他的动效路径，在calculatePath中计算弹性图形的形状
                _curveView.frame = CGRectMake(SCREEN_WIDTH/2, MIN_HEIGHT, 3, 3);
            } completion:^(BOOL finished) {
                if (finished) {
                    
                    _displayLink.paused = YES;
                    _isAnimating = NO;
                }
            }];
        }
    }
}

- (void)updateShapeLayerPath{
    //更新_shapeLayer形状
    UIBezierPath *tPath = [UIBezierPath bezierPath];
    [tPath moveToPoint:CGPointMake(0,0)];
    [tPath addLineToPoint:CGPointMake(SCREEN_WIDTH, 0)];
    [tPath addLineToPoint:CGPointMake(SCREEN_WIDTH, MIN_HEIGHT)];
    [tPath addQuadCurveToPoint:CGPointMake(0, MIN_HEIGHT) controlPoint:CGPointMake(_curveX, _curveY)];
    
    [tPath closePath];
    
    _shapeLayer.path = tPath.CGPath;
}

- (void)calculatePath{
    
    CALayer *layer = _curveView.layer.presentationLayer;
    self.curveX = layer.position.x;
    self.curveY = layer.position.y;
//    [self updateShapeLayerPath];
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:kX];
    [self removeObserver:self forKeyPath:kY];
}



@end
