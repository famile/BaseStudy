//
//  YXWeakScriptMessageDelegate.m
//  XZDShop
//
//  Created by 李涛 on 2019/5/15.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "YXWeakScriptMessageDelegate.h"

@implementation YXWeakScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate
{
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}

@end
