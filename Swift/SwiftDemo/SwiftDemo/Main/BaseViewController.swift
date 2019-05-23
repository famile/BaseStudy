//
//  BaseViewController.swift
//  SwiftDemo
//
//  Created by 李涛 on 2018/6/14.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    private var _statusBarHiddenStauts:Bool?
    private var _statusBarStyle:UIStatusBarStyle?
    
    /// 重写方法
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    /// 重写父类的init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)方法
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        _statusBarHiddenStauts = false;
        _statusBarStyle =  UIStatusBarStyle.lightContent;
    }
    
    /// 重载父类的init()
    init(name: String) {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fd_prefersNavigationBarHidden = true
        // Do any additional setup after loading the view.
        print(type(of: self))
        self.initConfig()
    }

    
    //MARK: httpRequest
    
    //MARK: click
    @objc private func tapEndEdit(sender:UITapGestureRecognizer){
        print("tap self.view")
        self.view.endEditing(true)
        
    }
    
    //MARK: private method
    func addBGReturnKeyboard() {
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapEndEdit(sender:)))
        
        self.view.addGestureRecognizer(tap)
    }
    
    func showStatusBar(){
        _statusBarHiddenStauts = false
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    func hideStatusBar(){
        _statusBarHiddenStauts = true
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    func showLightStatusBarStyle(){
        _statusBarStyle = UIStatusBarStyle.lightContent
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    func showDarkStatusBarStyle(){
        _statusBarStyle = UIStatusBarStyle.`default`
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    //MARK: setter
    
    
    //MARK: init
    
    
    func initConfig() {
        _statusBarHiddenStauts = false
        _statusBarStyle = UIStatusBarStyle.lightContent
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white
        self.showLightStatusBarStyle()
    }
    
    // 隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        get {
            return _statusBarHiddenStauts!
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        get {
            return _statusBarStyle!
        }
    }
    
    deinit {
        print("\(type(of: self))释放了")
    }
}

