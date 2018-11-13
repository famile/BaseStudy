//
//  MyControl.swift
//  SwiftDemo
//
//  Created by 李涛 on 2018/6/20.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

import Foundation
import UIKit

class MyControl: NSObject {
    
    class func createLabel(_ frame:CGRect, _ font:UIFont?, _ text:String, _ color:UIColor?, _ textAlignment:NSTextAlignment, _ numberLines:NSInteger) -> UILabel {
        let label = UILabel.init(frame: frame)
        if font != nil {
            label.font = font
        }
        
        if !text.isEmpty {
            label.text = text
        }
        
        if color != nil {
            label.textColor = color
        }
        
        label.textAlignment = textAlignment
        
        if numberLines >= 0 {
            label.numberOfLines = numberLines
        }
        return label
    }
    
    
    class func createNormalBtn(_ frame:CGRect, _ imageName:String, _ text:String, _ font:UIFont?, _ color:UIColor?, _ target: Any?, _ action: Selector) -> UIButton{
        let btn = UIButton(type: UIButtonType.custom)
        btn.frame = frame
        btn.setTitleColor(UIColor.black, for: UIControlState.normal)
        if !imageName.isEmpty {
            btn.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
        }
        
        btn.setTitle(text, for: UIControlState.normal)
        
        if font != nil {
            btn.titleLabel?.font = font
        }
        if color != nil {
            btn.setTitleColor(color, for: UIControlState.normal)
        }
        
        btn.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        
        return btn
    }

    
}


