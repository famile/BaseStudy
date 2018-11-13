//
//  MHSearchFriendsHeaderView.h
//  WeChat
//
//  Created by senba on 2017/9/22.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHReactiveView.h"
@interface MHSearchFriendsHeaderView : UIView<MHReactiveView>
+ (instancetype)headerView;

/// 点击搜索框的事件回调
@property (nonatomic, readwrite, copy) void(^searchCallback)(MHSearchFriendsHeaderView * headerView);
@end
