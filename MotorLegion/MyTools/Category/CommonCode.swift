//
//  CommonCode.swift
//  MotoLegion
//
//  Created by gemaojing on 16/8/30.
//  Copyright © 2016年 葛茂菁. All rights reserved.
//

import UIKit


// 用法直接调用 hexStringToColor 方法
///  -- 对UIColor扩展 16进制转化UIcolor
    
public func hexStringTotoColor(hexString: String) -> UIColor{
        var cString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if cString.characters.count < 6 {return UIColor.black}
        if (cString.hasPrefix("0X")) {
            cString = (cString as NSString).substring(from: 2)
        }
    
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if cString.characters.count != 6 {return UIColor.black}
        
        var range: NSRange = NSMakeRange(0, 2)
        
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        Scanner.init(string: rString).scanHexInt32(&r)
        Scanner.init(string: gString).scanHexInt32(&g)
        Scanner.init(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1))
        
}

public func setnavbackImg(vc:UIViewController) {
    
//    vc.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "nav_back")
//    vc.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "nav_back")
//    vc.navigationController?.navigationBar.barTintColor = UIColor.yellow
//    vc.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.orange]
//    vc.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "header_back_icon")
//    vc.navigationController?.navigationBar.barStyle = UIBarStyle.black
//    vc.navigationController?.navigationBar.
//    UIBarButtonItem().setBackgroundImage(UIImage(named: "nav_back"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
//    vc.navigationController?.navigationItem.backBarButtonItem?.setBackgroundImage(UIImage(named: "nav_back"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
    vc.navigationItem.backBarButtonItem?.setBackgroundImage(UIImage(named: "nav_back"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
    
    vc.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
}

public func panEdgeBack(vc:UIViewController,action:Selector){
    let target = vc.navigationController?.interactivePopGestureRecognizer?.delegate
    let pan = UIPanGestureRecognizer.init(target: target, action: action)
    pan.delegate = vc as? UIGestureRecognizerDelegate
    vc.view.addGestureRecognizer(pan)
}

//public func nav_back (vc:UIViewController){
//    
//    vc.navigationController?.interactivePopGestureRecognizer?.delegate = vc as? UIGestureRecognizerDelegate
//    
//    vc.navigationController?.popViewController(animated: true)
//    
//}





