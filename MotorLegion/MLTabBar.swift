//
//  MLTabBar.swift
//  MotorLegion
//
//  Created by gemaojing on 16/9/19.
//  Copyright © 2016年 葛茂菁. All rights reserved.
//

import UIKit

protocol MLTabBarDelegate:UITabBarDelegate{
     func tabBarDidClickPbtn(tabbar:MLTabBar)
}


class MLTabBar: UITabBar {
    
     var delegatee: MLTabBarDelegate?
     var plussBtn = UIButton()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
        
       config()
    }
    

    func config() {

        let plusBtn = UIButton.init(type: UIButtonType.custom)
        plusBtn.setBackgroundImage(UIImage.init(named: "post_normal"), for: UIControlState.normal)
        plusBtn.setTitle("广告", for: UIControlState.normal)
        plusBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        
        plusBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        plusBtn.titleEdgeInsets = UIEdgeInsetsMake(78, 0, 0, 0)
        plusBtn.frame.size = (plusBtn.currentBackgroundImage?.size)!
        plusBtn.addTarget(self, action: #selector(plusclick), for: UIControlEvents.touchUpInside)
        self.addSubview(plusBtn)
        self.plussBtn = plusBtn
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.plussBtn.center.x = self.frame.size.width * 0.5
        self.plussBtn.y = -25 // frame.origin.y
        
        let tabbarBtnW = self.frame.size.width / 5
        var tabbarBtnIndex = 0
        
        for child in self.subviews {
        let  classes = NSClassFromString("UITabBarButton")
            if child.isKind(of: classes!) {
                child.frame.size.width = tabbarBtnW
                child.frame.origin.x = CGFloat(tabbarBtnIndex) * tabbarBtnW
                tabbarBtnIndex += 1
                if tabbarBtnIndex == 2 {
                    tabbarBtnIndex  += 1
                }
            }
        }
    }
    
    
    func plusclick() {
        self.delegatee?.tabBarDidClickPbtn(tabbar: self)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}
