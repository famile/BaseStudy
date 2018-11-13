//
//  BaseDetailViewController.swift
//  SwiftDemo
//
//  Created by 李涛 on 2018/6/15.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

import UIKit

class BaseDetailViewController: BaseViewController {

    lazy var baseNavImageView:UIImageView = {() -> (UIImageView) in
        let baseNavImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kNavH))
        baseNavImageView.alpha = 0
        baseNavImageView.backgroundColor = UIColor.hexRGB(0x0a0b13, 1)
        baseNavImageView.isUserInteractionEnabled = true
        return baseNavImageView
    }()
    
    lazy var baseNavTitle:UILabel = { () -> (UILabel) in
        let baseNavTitle = UILabel.init(frame: CGRect.init(x: 0, y: kStatusBarH, width: 150, height: kNavH - kStatusBarH))
        baseNavTitle.centerX = self.baseNavImageView.centerX
        baseNavTitle.textAlignment = NSTextAlignment.center
        baseNavTitle.font = UIFont.customBoldFont(18)
        baseNavTitle.textColor = UIColor.white
        return baseNavTitle
    }()
    
    var backBtn:UIButton?
    var collectBtn:UIButton?
    var shareBtn:UIButton?
    
    var navRightBtn:UIButton?
    
    var navBGAlpha:CGFloat?
    
    var redPoint:UILabel?
    
    private var backClick:(()->())?
    private var rightClick:(()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: - httpRequest
    
    
    //MARK: - click
    
    @objc private func clickBackBtn() {
        self.backClick!()
    }
    
    @objc private func clickRightBtn(){
        self.rightClick!()
    }
    
    //MARK: - private method
    
    func createNavWithTitle(_ title:String, _ backImg:String, _ rightImg:String, _ rightTitle:String, _ backClick: (()->())?, _ rightClick: (()->())?){
        self.view.addSubview(self.baseNavImageView)
//        if !title.isEmpty {
        self.baseNavTitle.text = title
        self.view.addSubview(self.baseNavTitle)
//        }
        self.baseNavImageView.alpha = 1
        
        self.backClick = backClick
        self.rightClick = rightClick
        if backClick != nil {
            self.backBtn = MyControl.createNormalBtn(CGRect.init(x: 0, y: kStatusBarH, width: 49, height: kNavH-kStatusBarH), backImg, rightTitle, nil, nil, self, #selector(clickBackBtn))
            self.view.addSubview(self.backBtn!)
        }
        
        if rightClick != nil {
            self.navRightBtn = MyControl.createNormalBtn(CGRect.init(x: kScreenWidth-49, y: kStatusBarH, width: 4, height: kNavH-kStatusBarH), rightImg, rightTitle, nil, nil, self, #selector(clickRightBtn))
            self.view.addSubview(self.navRightBtn!)
        }
        
        
    }
    
    //MARK: - setter
    
    
    //MARK: - init
    
    func initUI(){
        
    }
    
    func createNav(){
        
    }

}
