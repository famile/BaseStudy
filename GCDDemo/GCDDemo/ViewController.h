//
//  ViewController.h
//  GCDDemo
//
//  Created by 李涛 on 2017/4/6.
//  Copyright © 2017年 Tao_Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewControllerDelegate <NSObject>

@property (nonatomic, copy) NSString *className;

@end

@interface ViewController : UIViewController


@end

