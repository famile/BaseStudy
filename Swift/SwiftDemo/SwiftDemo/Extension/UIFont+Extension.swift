//
//  UIFont+Extension.swift
//  SwiftDemo
//
//  Created by 李涛 on 2018/6/20.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    class func customBoldFont(_ size:CGFloat) -> UIFont {
        return UIFont.init(name: "FZLanTingHeiS-DB1-GB", size: size)!
    }
    
    class func customRegularFont(_ size:CGFloat) -> UIFont {
        return UIFont.init(name: "FZLanTingKanHei-R-GBK", size: size)!
    }
    
    class func customDINFont(_ size:CGFloat) -> UIFont{
        return UIFont.init(name: "DINPro-CondBold", size: size)!
    }
}
