//
//  Theme.swift
//  SwiftDemo
//
//  Created by 李涛 on 2018/6/15.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

import Foundation
import UIKit

//MARK: - 全局常用属性

public let kScreenWidth:CGFloat = UIScreen.main.bounds.size.width
public let kScreenHeight:CGFloat = UIScreen.main.bounds.size.height
public let kScreenBounds:CGRect = UIScreen.main.bounds


public let IS_IPAD:Bool = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)
public let IS_IPHONE:Bool = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)
public let IS_RETINA = UIScreen.main.scale >= 2.0

public let kSCREEN_MAX_LENGTH:CGFloat = max(kScreenWidth, kScreenHeight)
public let kSCREEN_MIN_LENGTH:CGFloat = min(kScreenWidth, kScreenHeight)

public let IS_IPHONE_4_OR_LESS:Bool = (IS_IPHONE && kSCREEN_MAX_LENGTH < 568.0)
public let IS_IPHONE_5:Bool = (IS_IPHONE && kSCREEN_MAX_LENGTH == 568.0)
public let IS_IPHONE_6:Bool = (IS_IPHONE && kSCREEN_MAX_LENGTH == 667.0)
public let IS_IPHONE_6P:Bool = (IS_IPHONE && kSCREEN_MAX_LENGTH == 736.0)
public let IS_IPHONE_X:Bool = (IS_IPHONE && kSCREEN_MAX_LENGTH == 812.0)


/// 适配的缩放比例
public let kSCALE:CGFloat = kScreenWidth/375.0

public let kNavH:CGFloat = (IS_IPHONE_X ? 88.0 : 64.0)
public let kStatusBarH:CGFloat = (IS_IPHONE_X ? 44.0 : 20.0)
public let kTabbarH:CGFloat = (IS_IPHONE_X ? 83.0 : 49.0)

public let kThemeColor = UIColor.hexRGB(0xffea01, 1)


