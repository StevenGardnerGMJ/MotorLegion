//
//  ViewController.swift
//  MotorLegion
//
//  Created by gemaojing on 16/9/18.
//  Copyright © 2016年 葛茂菁. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIGestureRecognizerDelegate,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.orange
        
        setnavbackImg(vc: self)
        
        // 系统返回手势
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

