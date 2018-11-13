//
//  BlockFuncModel.m
//  BaseStudy
//
//  Created by 李涛 on 2018/8/3.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

#import "BlockFuncModel.h"

@interface BlockFuncModel()

{
    NSInteger _sum;
}

@end

@implementation BlockFuncModel

- (void)dealloc{
    NSLog(@"block销毁了");
}

- (BlockFuncModel *(^)(NSInteger))add{
    
    return ^(NSInteger a){
        _sum += a;
        NSLog(@"%@",@(_sum));
        return self;
    };
}

@end
