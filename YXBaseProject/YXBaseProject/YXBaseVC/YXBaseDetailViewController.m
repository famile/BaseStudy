//
//  YXBaseDetailViewController.m
//  YXVC
//
//  Created by 李涛 on 2017/5/26.
//  Copyright © 2017年 Tao_Lee. All rights reserved.
//

#import "YXBaseDetailViewController.h"
#import "YXBaseVCHeader.h"
@interface YXBaseDetailViewController ()

@property (nonatomic, copy) void(^backClick)(void);
@property (nonatomic, copy) void(^shareClick)(void);
@property (nonatomic, copy) void(^collectClick)(void);
@property (nonatomic, copy) void(^rightBtnClick)(void);
//@property (nonatomic, strong) UIToolbar *toolBar;

//@property (nonatomic, strong) UIView *toolView;

@end

@implementation YXBaseDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.layer.masksToBounds = YES;
    
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


#pragma mark - httpRequest

#pragma mark - click

- (void)clickBackBtn{
    self.backClick();
}

- (void)clickShareBtn{
    self.shareClick();
}

- (void)clickCollectBtn{
    self.collectClick();
}

- (void)clickRightBtn{
    self.rightBtnClick();
}

#pragma mark - init

- (void)initUI{
    
}

- (void)createNavWithTitle:(NSString *)title andBackImage:(NSString *)backImg andShareImg:(NSString *)shareImg andCollectBtn:(NSString *)collectImg andBackClick:(void (^)(void))backClick andShareClick:(void (^)(void))shareClick andCollectClick:(void (^)(void))collectClick{
    
    UIView *view = [MyControl createViewWithFrame:CGRectMake(0, 0, kScreenWidth, NavH) andBGColor:[UIColor clearColor]];
    [self.view addSubview:view];
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = view.frame;
    layer.colors = @[(__bridge id)ColorFrom0xRGBWithAlpha(0x000000, 0.8).CGColor,(__bridge id)ColorFrom0xRGBWithAlpha(0x000000, 0.01).CGColor];
    layer.locations = @[@0.0,@1.0];
    [view.layer addSublayer:layer];
    
    [self.view addSubview:self.baseNavImageView];
    
    if (title && title.length > 0) {
        self.baseNavTitle.text = title;
        [self.baseNavImageView addSubview:self.baseNavTitle];
    }
    _backClick = backClick;
    _shareClick = shareClick;
    _collectClick = collectClick;
    
    if (backClick != nil) {
        _backBtn = [MyControl createButtonWithFrame:CGRectMake(0, DEVICE_STATUS_BAR_HEIGHT, 49, self.baseNavImageView.height - DEVICE_STATUS_BAR_HEIGHT) ImageName:backImg Target:self Action:@selector(clickBackBtn) Title:nil];
        [self.view addSubview:_backBtn];
    }
    
    if (shareClick != nil) {
        _shareBtn = [MyControl createButtonWithFrame:CGRectMake(kScreenWidth - 44, DEVICE_STATUS_BAR_HEIGHT, 44, self.baseNavImageView.height-DEVICE_STATUS_BAR_HEIGHT) ImageName:shareImg Target:self Action:@selector(clickShareBtn) Title:nil];
        [self.view addSubview:_shareBtn];
    }
    
    if (collectClick != nil) {
        _collectBtn = [MyControl createButtonWithFrame:(CGRectMake(kScreenWidth - 56 - 44, DEVICE_STATUS_BAR_HEIGHT, 56, self.baseNavImageView.height-DEVICE_STATUS_BAR_HEIGHT)) ImageName:collectImg Target:self Action:@selector(clickCollectBtn) Title:nil];
        [self.view addSubview:_collectBtn];
    }
    
}


- (void)createNavWithTitle:(NSString *)title
              andBackImage:(NSString *)backImg
               andRightImg:(NSString *)rightImg
          andRightBtnTitle:(NSString *)rightTitle
              andBackClick:(void(^)(void))backClick
             andRightClick:(void(^)(void))rightClick{
    
    [self.view addSubview:self.baseNavImageView];
    if (title && title.length > 0) {
        self.baseNavTitle.text = title;
        [self.view addSubview:self.baseNavTitle];
    }else{
        self.baseNavTitle.text = @"";
        [self.view addSubview:self.baseNavTitle];
    }
    self.baseNavImageView.alpha = 1;
    _backClick = backClick;
    _rightBtnClick = rightClick;
    
    if (backClick != nil) {
        _backBtn = [MyControl createButtonWithFrame:CGRectMake(0, DEVICE_STATUS_BAR_HEIGHT, 49, self.baseNavImageView.height-DEVICE_STATUS_BAR_HEIGHT) ImageName:backImg Target:self Action:@selector(clickBackBtn) Title:nil];
        [self.view addSubview:_backBtn];
    }
    
    if (rightClick != nil) {
        UIButton *rightBtn = [MyControl createButtonWithFrame:(CGRectMake(kScreenWidth - 49, DEVICE_STATUS_BAR_HEIGHT, 49, self.baseNavImageView.height-DEVICE_STATUS_BAR_HEIGHT)) ImageName:rightImg Target:self Action:@selector(clickRightBtn) Title:rightTitle];
        [self.view addSubview:rightBtn];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        rightBtn.titleLabel.font = CustomRegularFont(16);
        _navRightBtn = rightBtn;
    }
}




-(UIImageView *)baseNavImageView{
    if (!_baseNavImageView) {
        _baseNavImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, NavH)];
        _baseNavImageView.backgroundColor = ColorFrom0xRGB(0xffffff);
//        _baseNavImageView.backgroundColor = Color_blackBG;
        _baseNavImageView.alpha = 0;
        _baseNavImageView.userInteractionEnabled = YES;
    }
    return _baseNavImageView;
}

-(UILabel *)baseNavTitle{
    if (!_baseNavTitle) {
        _baseNavTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, DEVICE_STATUS_BAR_HEIGHT, 150, self.baseNavImageView.height-DEVICE_STATUS_BAR_HEIGHT)];
        _baseNavTitle.centerX = self.baseNavImageView.centerX;
        _baseNavTitle.textAlignment = NSTextAlignmentCenter;
        _baseNavTitle.font = CustomBoldFont(18);
        _baseNavTitle.textColor = [UIColor blackColor];
    }
    return _baseNavTitle;
}

- (UILabel *)homePageTitle{
    if (!_homePageTitle) {
        _homePageTitle = [MyControl createLabelWithFrame:(CGRectZero) FontName:CustomBoldFont(24) Text:@"" color:ColorFrom0xRGB(0xffffff) textAlignment:(NSTextAlignmentLeft) numberLines:1];
    }
    return _homePageTitle;
}

- (void)setNavBGAlpha:(CGFloat)navBGAlpha{
    _navBGAlpha = navBGAlpha;
    _baseNavImageView.alpha = navBGAlpha;

}



@end
