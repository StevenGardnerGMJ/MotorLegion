//
//  MLNavController.swift
//  MotorLegion
//
//  Created by gemaojing on 16/9/18.
//  Copyright © 2016年 葛茂菁. All rights reserved.
//

import UIKit

class MLNavController: UINavigationController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        print("页面推")
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = false
            let backBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 68, height: 68))
            let img_back = UIImage(named: "header_back_icon")
            backBtn.setImage(img_back, for: UIControlState.normal)
            backBtn.addTarget(self, action: #selector(backnav), for: UIControlEvents.touchUpInside)
            let  barbtn_back = UIBarButtonItem(customView: backBtn)
            let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
            spacer.width = -30
            viewController.navigationItem.leftBarButtonItems = [spacer,barbtn_back]
            
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
        func backnav() {
        self.popViewController(animated: true)
    }
    

}







