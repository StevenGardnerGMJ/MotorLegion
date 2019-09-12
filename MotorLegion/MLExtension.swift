//
//  MLExtension.swift
//  MotorLegion
//
//  Created by gemaojing on 16/9/19.
//  Copyright © 2016年 葛茂菁. All rights reserved.
//

import UIKit



class MLExtension: NSObject {
    
    // 扩展 系统方法
}

public enum baseRefreshState {
    case new
    case first
    case more
}

extension UIViewController {
    func postHttpWithUrlString(url:String,
                        parameters:[String:Any]?,
                        showHUDStr:String?,
                 completionHandler:@escaping(_ jsonData:JSON?)->Void) {
        if let showHUDStr = showHUDStr {
            HUD.manager.showHUDWihtTitle(string: showHUDStr)
        }
        var postDict = [String:Any]()
        if let userID = UserId.objForKey {
            postDict["userId"] = "\(UserId)"
            postDict["headUserId"] = "\(UserId)"
        } else {
            postDict["headUserId"] = "1"
            let notUserIdUrl = ""
            if !notUserIdUrl.contains(url) {
                if let _ = showHUDStr {
                    HUD.manager.dismiss()
                }
                return
            }
        }
        if let authToken = authToken.objForKey {
            postDict["headAuthToken"] = authToken
        } else {
            postDict["headAuthToken"] = "aàáâäæãåā"
        }
    
        postDict["headSerialNo"] = "\(Int(Date().timeIntervalSince1970*10000))\(Int(Date().timeIntervalSince1970*10000))\(arc4random()%1000)"//随机数
        postDict["headTrTime"] = "\(Int(Date().timeIntervalSince1970*1000))"
        printt(url)
        printt(postDict)
        
        
    }
}



/// 在键盘上显示“完成” 按钮,背景灰色
extension UITextField {
    func showFinishButtonTitle(title:String)  {
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: 30))
        inputView.backgroundColor = UIColor(white: 0.8, alpha: 1)
        let button = UIButton(type: .system)
        button.frame = CGRect(x: SCREEN_W-50, y: 0, width: 50, height: inputView.frame.height)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(onHideKeyboard), for: .touchUpInside)
        inputView.addSubview(button)
        self.inputAccessoryView = inputView
    }
    func onHideKeyboard()  {
        self.resignFirstResponder()
    }
}

// 视图扩展: get set 方法全部无效，原因不详
extension UIView {
    var x:CGFloat {
        get{return self.frame.origin.x}
        set{ var frame = self.frame
             frame.origin.x = newValue
             self.frame = frame
        }
    }
    
    var y:CGFloat {
      get {return self.frame.origin.y}
        set {var frame = self.frame
             frame.origin.y = newValue
             self.frame = frame
        }
    }
    
    var centerX:CGFloat {
        get{return self.center.x}
        set{ var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
    var centerY:CGFloat {
        get{ return self.center.y}
        set{ var center = self.center
            center.y = newValue
            self.center = center
        }
        
    }
    
    var width:CGFloat {
        get{return self.frame.size.width}
        set{ var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    var height:CGFloat {
        get{ return self.frame.size.height }
        set{ var frame = self.frame
             frame.size.height = newValue
             self.frame = frame
        }
    }
    
    var size:CGSize {
        get{return self.frame.size}
        set{ var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    
    var origin:CGPoint {
        get{ return self.frame.origin }
        set{ var frame = self.frame
             frame.origin = newValue
             self.frame = frame
        }
    }
}
// 图片扩展
extension UIImage {
    func imageWithColor(color:UIColor) -> UIImage{
        let  rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()! as CGContext
        context.setFillColor(color as! CGColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    
    }
}
// 字符串扩展
extension String {
    func addtime(time:String) -> String {
        let fmt = DateFormatter()
        fmt.locale = Locale.init(identifier: "en_US")
        
        // 设置日期格式
        // 创建日期
        let createDate = Date.init(timeIntervalSince1970: (Double(time)! / 1000))
        // 当前时间
        let now = Date()
        // 日历对象
        let calendar = Calendar.current
        
        //let unit =Calendar.Component[.year, .month, .day, .hour, .minute,.second]
        let cmps = calendar.dateComponents([.year, .month, .day, .hour, .minute,.second], from: createDate, to: now)
        
        // do something ...
        if createDate.isThisYear { // 今年
            if createDate.isYesToday { // 昨天
                return fmt.string(from: createDate)
            } else if  createDate.isToday { // 今天
                if cmps.hour! >= 1 {
                    return String.init(appendingFormat("%d小时前", cmps.minute!))
                } else if (cmps.minute! >= 1) {
                    return String(format: "%d分钟前", cmps.minute!)
                } else {
                    return "刚刚"
                }
                
            } else { // 今年其他日子
                fmt.dateFormat = "MM-dd HH:mm"
                return fmt.string(from: createDate)
            }
        } else { // 非今年
            fmt.dateFormat = "yyyy-MM-dd"
            return fmt.string(from: createDate)
        }
        
    }
    
    func sizeWithTextfont(font:UIFont, maxW:CGFloat)-> CGSize{
        var attrs:Dictionary<String,UIFont> = Dictionary()
        attrs[NSFontAttributeName] = font
        let  maxSize = CGSize(width: maxW, height: CGFloat(MAXFLOAT))
        let resize = self.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrs, context: nil).size
        return resize
    }
    
    func sizewithTextFont(font:UIFont) -> CGSize{
        let resize = self.sizeWithTextfont(font: font, maxW: CGFloat(MAXFLOAT))
        return resize
    }
}


extension Date {
    
    // 清空时分秒 除去时间尾巴
   var ymdDate:Date {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        let dateString = fmt.string(from: self)
        let date = fmt.date(from: dateString)
        return date!
    }
    // 时间戳
    var timestamp:String {
        
        // "%.0f\(timeInterval)"
        let timeInterval = self.timeIntervalSince1970
        let timeString:String =  String(format: "%.0f", timeInterval)
        return timeString
    }
    // 时间成分
    var components:DateComponents {
        
       let calendar = Calendar.current
       let reCalendar =  calendar.dateComponents([.year, .month, .day, .hour, .minute,.second], from: self)
        
        return reCalendar
    }
    
    // 比较
    func calWithValue(value:NSInteger) -> Bool {
        let dateComponents:DateComponents = self.ymdDate.components
        let nowComponents = Date().ymdDate.components
        let res = dateComponents.year! == nowComponents.year && dateComponents.month == nowComponents.month && (dateComponents.day! + value) == nowComponents.day!
        return res
    }
    
    // 今年
    var isThisYear:Bool {
        let dateComponents = self.components
        let nowComponents = Date().components
        let res:Bool = dateComponents.year == nowComponents.year
        return res
    }
    
    // 今天
    var isToday:Bool {
        return self.calWithValue(value: 0)
    }
    
    // 昨天
    var isYesToday:Bool {
        return calWithValue(value: 1)
    }
    
    // 两个时间比较
    func dateComponents(unit:Set<Calendar.Component>, fromDate:Date, toDate:Date) -> DateComponents {
        
        let calendar = Calendar.current
        
        let components = calendar.dateComponents(unit, from: fromDate, to: toDate)
        
        return components;
    }
}

extension UIBarButtonItem {
    func createItemWithTarget(target:Any?, action:Selector, image:String, hightligtImage:String) -> UIBarButtonItem {
        
        let btn = UIButton.init(type: UIButtonType.custom)
//        btn.setBackgroundImage(UIImage.init(named: image), for: UIControlState.normal)
//        btn.setBackgroundImage(UIImage.init(named: hightligtImage), for: UIControlState.highlighted)
        btn.setImage(UIImage.init(named: image), for: UIControlState.normal)
        btn.setImage(UIImage.init(named: hightligtImage), for: UIControlState.highlighted)
//        btn.setTitle(" ", for: UIControlState.normal)
        
        btn.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
//        btn.size = (btn.currentBackgroundImage?.size)!
//        btn.size = (btn.currentImage?.size)!
        btn.frame = CGRect(x:0, y: 0, width: 25, height: 25)
        
        return UIBarButtonItem(customView: btn)
    }
}
/// 获取设备型号
public extension UIDevice {
    var modelName:String {
        var systenInfo = utsname()//【uname系统调用】功能描述:获取当前内核名称和其它信息。
        uname(&systenInfo)
        let machineMirror = Mirror(reflecting: systenInfo.machine)
        let identifier = machineMirror.children.reduce(""){ identifier, element in
    guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1","iPhone9,3":                   return "iPhone 7"
        case "iPhone9,2","iPhone9,4":                   return "iPhone 7 plus"
        case "iPhone10,3":                              return "iPhone X"
        case "iPhone10,4":                              return "iPhone 8"
        case "iPhone10,5":                              return "iPhone 8 Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
}













