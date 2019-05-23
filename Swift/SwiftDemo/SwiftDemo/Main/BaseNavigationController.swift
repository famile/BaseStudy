//
//  BaseNavigationController.swift
//  SwiftDemo
//
//  Created by 李涛 on 2018/6/20.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.interactivePopGestureRecognizer?.delegate = self as UIGestureRecognizerDelegate
        
    }

    //MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool{
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            if self.viewControllers.count != 1 {
                return true
            }else {
                return false
            }
        }
        return true
    }
    
    //MARK: - httpRequest
    
    
    //MARK: - click
    
    
    //MARK: - private method
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    //MARK: - setter
    
    
    //MARK: - init
    
    

    

}
