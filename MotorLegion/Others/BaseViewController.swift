//
//  BaseViewController.swift
//  MotorLegion
//
//  Created by gemaojing on 2017/10/26.
//  Copyright © 2017年 葛茂菁. All rights reserved.
//

import UIKit

typealias BaseBlock = (_ obj: Any?)-> Void

class BaseViewController: UIViewController {
    
    var baseBlock:BaseBlock?
    var pageNo = 1
    var isLoad : Bool = true
    
    lazy var navView:UIImageView = {
        let navView = UIImageView()
        navView.image = UIImage(named: "bg")
        navView.isUserInteractionEnabled = true
        navView.backgroundColor = UIColor.white
        return navView
    }()
    lazy var leftButton:UIButton = {
        let view = UIButton()
        return view
    }()
    lazy var rightButton:UIButton = {
       let view = UIButton()
       return view
    }()
    lazy var titleButton:UIButton = {
        let view = UIButton()
        return view
    }()
    
    lazy var lineImage:UIImageView = {
        let view = UIImageView()
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(navView)
        navView.addSubview(leftButton)
        navView.addSubview(rightButton)
        navView.addSubview(titleButton)
        navView.addSubview(lineImage)
        
        leftButton.addTarget(self, action: #selector(leftButtonSelect), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonSelect), for: .touchUpInside)
        titleButton.addTarget(self, action: #selector(titleButtonSelect), for: .touchUpInside)

        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        titleButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        lineImage.image = UIImage(named: "bgLine")
        
        navView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(63.5)
        }
        leftButton.snp.makeConstraints { (make) in
            make.left.equalTo(9)
            make.top.equalTo(20)
            make.bottom.equalTo(navView)
            make.width.greaterThanOrEqualTo(44)
        }
        rightButton.snp.makeConstraints { (make) in
            make.right.equalTo(-5)
            make.top.equalTo(20)
            make.bottom.equalTo(navView)
            make.width.greaterThanOrEqualTo(44)
        }
        titleButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(navView)
            make.top.equalTo(20)
            make.bottom.equalTo(navView)
            make.width.lessThanOrEqualTo(200)
        }
        lineImage.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(1)
        }
        
    }
    func addBaseBlock(blcok: @escaping BaseBlock){
        self.baseBlock = blcok
    }
    func addLeftNavButton(title:String)  {
        let isPng  = title.hasSuffix("png")
        let isJpg  = title.hasSuffix("jpg")
        let isJpeg = title.hasSuffix("jpeg")
        if isPng || isJpg || isJpeg {
            rightButton.setImage(UIImage(named: title), for: .normal)
        } else {
            rightButton.setTitle(title, for: .normal)
        }
    }
    func addRightNavButton(title:String){
        let isPng  = title.hasSuffix("png")
        let isJpg  = title.hasSuffix("jpg")
        let isJpeg = title.hasSuffix("jpeg")
        if isPng || isJpg || isJpeg {
            rightButton.setImage(UIImage(named: title), for: .normal)
        } else {
            rightButton.setTitle(title, for: .normal)
        }
    }
    func addTitle(title:String)  {
        let isPng  = title.hasSuffix("png")
        let isJpg  = title.hasSuffix("jpg")
        let isJpeg = title.hasSuffix("jpeg")
        if isPng || isJpg || isJpeg {
            rightButton.setImage(UIImage(named: title), for: .normal)
        } else {
            rightButton.setTitle(title, for: .normal)
        }
    }
    func leftButtonSelect()  {
    }
    func rightButtonSelect() {
    }
    func titleButtonSelect() {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}



