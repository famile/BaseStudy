//
//  YXMineViewController.swift
//  SwiftDemo
//
//  Created by 李涛 on 2018/6/20.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

import UIKit

class YXMineViewController: BaseDetailViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK: - httpRequest
    
    
    //MARK: - click
    
    
    //MARK: - private method
    
    
    //MARK: - setter
    
    
    //MARK: - init
    
    override func initUI() {
        createNav()
    }
    
    override func createNav() {
        weak var ws = self
        self.createNavWithTitle("我的", "", "", "", nil, nil)
    }

}
