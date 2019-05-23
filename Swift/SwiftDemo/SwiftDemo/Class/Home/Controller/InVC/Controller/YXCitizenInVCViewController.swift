//
//  YXCitizenInVCViewController.swift
//  SwiftDemo
//
//  Created by 李涛 on 2018/6/20.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

import UIKit

class YXCitizenInVCViewController: BaseDetailViewController {

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
        self.createNavWithTitle("谁在玩", "back", "", "", {
            ws?.navigationController?.popViewController(animated: true)
        }, nil)
    }
    

}
