//
//  UIView+Extension.swift
//  UICollectionView-test
//
//  Created by 李涛 on 16/7/18.
//  Copyright © 2016年 Tao_Lee. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    var x : CGFloat {
        return self.frame.origin.x
    }
    
    var y : CGFloat {
        return self.frame.origin.y
    }
    
    var width : CGFloat {
        return self.frame.size.width
    }
    
    var height: CGFloat {
        return self.frame.size.height
    }
    
    var right : CGFloat {
        return x + width
    }
    
    var bottom : CGFloat {
        return y + height
    }
    
    var centerX : CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center.x = newValue
        }
        
    }
    
    var centerY : CGFloat {
        return self.center.y
    }
}
