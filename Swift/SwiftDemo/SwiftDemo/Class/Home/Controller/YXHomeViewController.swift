//
//  YXHomeViewController.swift
//  SwiftDemo
//
//  Created by 李涛 on 2018/6/20.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

import UIKit

class YXHomeViewController: BaseDetailViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.showLightStatusBarStyle()
//        self.hideStatusBar()
    }

    //MARK: - httpRequest
    
    
    //MARK: - click
    
    
    //MARK: - private method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.pushViewController(YXCitizenInVCViewController(), animated: true) 
    }
    
    //MARK: - setter
    
    
    //MARK: - init
    
    override func initUI() {
        createNav()
        self.baseNavTitle.text = "123"
    }
    
    override func createNav() {
        weak var ws = self
        self.createNavWithTitle("首页", "", "", "", nil, nil)
    }
}
