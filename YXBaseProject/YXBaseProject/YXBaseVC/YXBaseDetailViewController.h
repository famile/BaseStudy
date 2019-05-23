//
//  YXBaseDetailViewController.h
//  YXVC
//
//  Created by 李涛 on 2017/5/26.
//  Copyright © 2017年 Tao_Lee. All rights reserved.
//

#import "BaseViewController.h"

@interface YXBaseDetailViewController : BaseViewController

@property (nonatomic, strong) UILabel *baseNavTitle;
@property (nonatomic, strong) UILabel *homePageTitle;
@property (nonatomic, strong) UIImageView *baseNavImageView;  /**< 导航背景 */
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIButton *backBtn;  /**< 返回 */
@property (nonatomic, strong) UIButton *collectBtn;  /**< 收藏 */
@property (nonatomic, strong) UIButton *shareBtn; /**< 分享 */

@property (nonatomic, strong) UIButton *navRightBtn; /**< 右按钮 */

@property (nonatomic, assign) CGFloat navBGAlpha;

@property (nonatomic, strong) UILabel *redPoint;

//初始化页面
- (void)initUI;

//@property (nonatomic,strong) UIButton *originBackBtn;  /**< 返回 */
//@property (nonatomic,strong) UIButton *originCollectBtn;  /**< 收藏 */
//@property (nonatomic,strong) UIButton *originShareBtn; /**< 分享 */


/**
 左边返回，右边两个按钮

 @param title <#title description#>
 @param backImg <#backImg description#>
 @param shareImg <#shareImg description#>
 @param collectBtn <#collectBtn description#>
 @param backClick <#backClick description#>
 @param shareClick <#shareClick description#>
 @param collectClick <#collectClick description#>
 */
- (void)createNavWithTitle:(NSString *)title
              andBackImage:(NSString *)backImg
               andShareImg:(NSString *)shareImg
             andCollectBtn:(NSString *)collectBtn
              andBackClick:(void(^)(void))backClick
             andShareClick:(void(^)(void))shareClick
           andCollectClick:(void(^)(void))collectClick;



/**
 普通的导航栏

 @param title <#title description#>
 @param backImg <#backImg description#>
 @param rightImg <#rightImg description#>
 @param rightTitle <#rightTitle description#>
 @param backClick <#backClick description#>
 @param rightClick <#rightClick description#>
 */
- (void)createNavWithTitle:(NSString *)title
              andBackImage:(NSString *)backImg
               andRightImg:(NSString *)rightImg
          andRightBtnTitle:(NSString *)rightTitle
              andBackClick:(void(^)(void))backClick
             andRightClick:(void(^)(void))rightClick;







@end
