//
//  SingleClass.swift
//  MotorLegion
//
//  Created by gemaojing on 2017/11/8.
//  Copyright © 2017年 葛茂菁. All rights reserved.
//

import UIKit

class SingleClass: NSObject {

    var userJson:JSON = []
    var moneyJson:JSON = []
    var loginInPassword = 0
    static let shared = SingleClass()
    private override init() {
        super.init()
    }
    class func getString(key:String)-> String {
        let str = Bundle.main.localizedString(forKey: key, value: nil, table: nil)
        return str
    }
}
