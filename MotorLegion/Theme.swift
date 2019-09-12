//
//  Theme.swift
//  MotorLegion
//
//  Created by gemaojing on 2017/10/24.
//  Copyright © 2017年 葛茂菁. All rights reserved.
//

import UIKit


///  -- 屏幕高
public let SCREEN_H = UIScreen.main.bounds.size.height
///  -- 屏幕宽
public let SCREEN_W = UIScreen.main.bounds.size.width
///  -- 主屏幕尺寸
public let MainBounds = UIScreen.main.bounds
//   -- TabBar高度
public let TabBar_H = 49
//   -- NavBar高度
public let NavigationBar_H = 64
//   -- 抛去Nav和Tab 剩下的间距
public let SizeWithOutNavOrTabbar = CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H - CGFloat(TabBar_H + NavigationBar_H))


let httpaddress = "https://api.apphttp.com占位数据" // 根服务器地址
public let httpHead = "\(httpaddress)/拼接web地址服务"
public let httpImageHead = "\(httpaddress)/:8081/拼接端口地址"
public let httpWebHead = "\(httpaddress)/html/拼接HTML地址"
public let httpShopHead = "\(httpaddress)/购物货品支付类端接口"

public let UserId = "user_id"
public let authToken = "authToken"

typealias IndexBlock = (_ index : Int) -> Void
public let constraitHeight: CGFloat = SCREEN_H/667
public let page_size = 30


public let defaultTextlightColor179 = UIColor(red: 179/255.0, green: 179/255.0, blue: 179/255.0, alpha: 1)

public let defaultPurpleColor = UIColor(red: 162/255.0, green: 114/255.0, blue: 255/255.0, alpha: 1)

public let defaultTextBlack51Color = UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)


// MARK: -颜色方法(带透明)
func RGBAColor(_ r: CGFloat, _ g: CGFloat , _ b:CGFloat,_ a:CGFloat)->UIColor{
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

// MARK: -颜色方法(不透明）
func RGBColor(_ r: CGFloat, _ g:CGFloat , _ b:CGFloat)->UIColor{
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}

// 打印 -- 自定义打印方法
func printt<T>(_ message: T, file: String = #file, funcName:String = #function, lineNum:Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\(fileName):(\(lineNum))~~~~\(message)")
    #endif
}


// 国际化
func LocalString (_ key:String) -> String {
    return Bundle.main.localizedString(forKey: key, value: nil, table: nil)
}


