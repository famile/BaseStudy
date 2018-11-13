//
//  BlockFuncModel.h
//  BaseStudy
//
//  Created by 李涛 on 2018/8/3.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlockFuncModel : NSObject
{
    @public
    NSString *_name;
}
@property (nonatomic, copy) NSString *name;

- (BlockFuncModel *(^)(NSInteger))add;

@end
