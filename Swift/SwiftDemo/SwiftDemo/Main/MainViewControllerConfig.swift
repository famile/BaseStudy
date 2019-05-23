//
//  MainViewControllerConfig.swift
//  SwiftDemo
//
//  Created by 李涛 on 2018/6/20.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

import Foundation


class MainViewControllerConfig: NSObject {
    
    lazy var tabBarController:CYLTabBarController = { () -> CYLTabBarController in
        let firstVC = YXHomeViewController.init()
        let secondVC = YXDiscoverViewController.init()
        let thirdVC = YXRankIndexViewController.init()
        let fourthVC = YXMineViewController.init()
        
        let firstNav = BaseNavigationController.init(rootViewController: firstVC)
        let secondNav = BaseNavigationController.init(rootViewController: secondVC)
        let thirdNav = BaseNavigationController.init(rootViewController: thirdVC)
        let fourthNav = BaseNavigationController.init(rootViewController: fourthVC)
        
        let tabbarController = CYLTabBarController.init()
        setupTabbarItemsAttributesForController(tabbarController)
        tabbarController.viewControllers = [firstNav,secondNav,thirdNav,fourthNav]
        customizeTabbarAppearance(tabbarController)
        tabbarController.selectedIndex = 0
        self.tabBarController = tabbarController
        return tabbarController
    }()
    
    //MARK: - httpRequest
    
    
    //MARK: - click
    
    
    //MARK: - private method
    func setupTabbarItemsAttributesForController(_ tabBarController:CYLTabBarController){
        let dict1 = [CYLTabBarItemTitle : "首页",
                     CYLTabBarItemImage : "tabbar_home_normal",
                     CYLTabBarItemSelectedImage : "tabbar_home_highlight"]
        
        let dict2 = [CYLTabBarItemTitle : "发现",
                     CYLTabBarItemImage : "tabbar_scene_normal",
                     CYLTabBarItemSelectedImage : "tabbar_scene_highlight"]
        
        let dict3 = [CYLTabBarItemTitle : "排行榜",
                     CYLTabBarItemImage : "tabbar_interact_normal",
                     CYLTabBarItemSelectedImage : "tabbar_interact_highlight"]
        
        let dict4 = [CYLTabBarItemTitle : "我的",
                     CYLTabBarItemImage : "tabbar_mine_normal",
                     CYLTabBarItemSelectedImage : "tabbar_mine_highlight"]
        tabBarController.tabBarItemsAttributes = [dict1,dict2,dict3,dict4]
    }
    
    func customizeTabbarAppearance(_ tabBarController:CYLTabBarController){
        let normalAttrs = NSMutableDictionary.init()
        normalAttrs[NSAttributedStringKey.foregroundColor] = UIColor.hexRGB(0x5c5c61, 1)
        normalAttrs[NSAttributedStringKey.font] = UIFont.customRegularFont(11)
        
        let selectedAttrs = NSMutableDictionary()
        selectedAttrs[NSAttributedStringKey.foregroundColor] = UIColor.hexRGB(0xffffff, 1)
        selectedAttrs[NSAttributedStringKey.font] = UIFont.customRegularFont(11)
        
        let tabbarItem = UITabBarItem.appearance()
        tabbarItem.setTitleTextAttributes(normalAttrs as? [NSAttributedStringKey : Any], for: UIControlState.normal)
        tabbarItem.setTitleTextAttributes(selectedAttrs as? [NSAttributedStringKey : Any], for: UIControlState.selected)
        
        let tabbar = UITabBar.appearance()
        tabbar.barTintColor = UIColor.hexRGB(0x0a0b13, 1)
        tabbar.isTranslucent = false
    }
    
    //MARK: - setter
    
    
    //MARK: - init
    
    
    
}
