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
        
        let a = 1
        let b = 2
        var c = a + b
        /// 参数标签
        /*
         func add(num1 a: Int, _ b: Int)
         
         */
        print(1, 2, c, separator: "")
        
        /*
         inout 函数内部修改外部变量
         可变参数不能标记为inout
         inout参数不能有默认值
         inout参数本质是地址传递（引用传递）
         inout只能传入能多次赋值的参数
         */
        add(&c)
        print(c)
        
        /*
         函数重载  （Function Overload）
         函数名相同
         参数个数不同 || 参数类型不同 || 参数标签不同
         注意：
         返回值类型与函数重载无关
         默认参数值 和 函数重载一起使用产生歧义
         
         func sum(v1: Int, v2: Int) -> Int {v1 + v2}
         func sum(v1: Int, v2: Int, v3: Int = 10) -> Int {v1 + v2 + v3}
         
         */
        
        
        /*
         枚举值：
            设置关联值（Associated Values）
            设置原始值
                 enum Grade: String {
                    case gread = "A"
                    case bad = "B"
                 }
            隐式原始值
                 enum Grade: String {
         
                 }
         */
        
        /*
         空合并运算符 ??
         
         guard 绑定的常量 可以在外层作用域使用
         特别适合提前退出
         */
     
        
        
        
        
    }

    //MARK: - httpRequest
    
    
    //MARK: - click
    
    
    //MARK: - private method
    
    func add(_ num: inout Int) {
        num += 1
    }
    
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
