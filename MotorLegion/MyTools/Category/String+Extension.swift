//
//  String+Extension.swift
//  ItmeButtonView
//
//  Created by lyl on 16/3/3.
//  Copyright © 2016年 miruo. All rights reserved.
//

import UIKit

//enum CryptoAlgorithm {
//    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
//
//    var HMACAlgorithm: CCHmacAlgorithm {
//        var result: Int = 0
//        switch self {
//        case .MD5:      result = kCCHmacAlgMD5
//        case .SHA1:     result = kCCHmacAlgSHA1
//        case .SHA224:   result = kCCHmacAlgSHA224
//        case .SHA256:   result = kCCHmacAlgSHA256
//        case .SHA384:   result = kCCHmacAlgSHA384
//        case .SHA512:   result = kCCHmacAlgSHA512
//        }
//        return CCHmacAlgorithm(result)
//    }
//
//    var digestLength: Int {
//        var result: Int32 = 0
//        switch self {
//        case .MD5:      result = CC_MD5_DIGEST_LENGTH
//        case .SHA1:     result = CC_SHA1_DIGEST_LENGTH
//        case .SHA224:   result = CC_SHA224_DIGEST_LENGTH
//        case .SHA256:   result = CC_SHA256_DIGEST_LENGTH
//        case .SHA384:   result = CC_SHA384_DIGEST_LENGTH
//        case .SHA512:   result = CC_SHA512_DIGEST_LENGTH
//        }
//        return Int(result)
//    }
//}

extension String {

//    func hmac(algorithm: CryptoAlgorithm, key: String) -> String {
//        let str = self.cString(using: String.Encoding.utf8)
//        let strLen = Int(self.lengthOfBytes(using: String.Encoding.utf8))
//        let digestLen = algorithm.digestLength
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
//        let keyStr = key.cString(using: String.Encoding.utf8)
//        let keyLen = Int(key.lengthOfBytes(using: String.Encoding.utf8))
//        CCHmac(algorithm.HMACAlgorithm, keyStr!, keyLen, str!, strLen, result)
//        let digest = stringFromResult(result: result, length: digestLen)
//        result.deallocate(capacity: digestLen)
//        return digest
//    }



    func randomSmallCaseString(length: Int) -> String {
        var output = ""
        for _ in 0..<length {
            let randomNumber = arc4random() % 26 + 97
            let randomChar = Character(UnicodeScalar(randomNumber)!)
            output.append(randomChar)
        }
        return output
    }

    var md5 : String{
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen);
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        return String(format: hash as String)
    }


    var sha1: String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA1(str!, strLen, result)
        return stringFromResult(result: result, length: digestLen)
    }
    private func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash)
    }



    var objForKey: String?{
        let objStr = UserDefaults.standard.object(forKey: self)
        if let objStr = objStr as? String {
            return objStr
        }
        return nil
    }

    var objectForKey: String{
        let objStr = UserDefaults.standard.object(forKey: self)
        if let objStr = objStr as? String {
            return objStr
        }
        return ""
    }

    var intUid: Int{
        let objStr = UserDefaults.standard.object(forKey: self)
        if let objStr = objStr as? String, let intuid = Int(objStr) {
            return intuid
        }
        return 0
    }


    func removeObjForKey() {
        UserDefaults.standard.removeObject(forKey: self)
    }


    /** 根据相应的宽度算出文字的高度*/
    func getHeightOfStringWithWidth(width: CGFloat, font: CGFloat) -> CGFloat {
         return self.boundingRect(with: CGSize(width: width, height: 2000), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: font)], context: nil).size.height
    }

    /** 汉子转带声调的拼音*/
    func chineseToPinyinWithShengDiao() -> String {
        let str = NSMutableString(string: self)
        CFStringTransform(str as CFMutableString, nil, kCFStringTransformMandarinLatin, false)
        CFStringTransform(str as CFMutableString, nil, kCFStringTransformStripDiacritics, false)
        return str as String
    }


    /** 汉字转拼音*/
    func chineseToPinyin() -> String {
        
        let aCFString = CFBridgingRetain(self) as! CFString
        let string = CFStringCreateMutableCopy(nil, 0, aCFString)
        CFStringTransform(string, nil, kCFStringTransformMandarinLatin, false)
        CFStringTransform(string, nil, kCFStringTransformStripDiacritics, false)
        return CFBridgingRetain(string) as! String
    }
    /** 匹配手机号是否合法*/
    func checkTelNumber() -> Bool {
        let mobile = "^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$"
        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: self) == true)
            || (regextestcm.evaluate(with: self)  == true)
            || (regextestct.evaluate(with: self) == true)
            || (regextestcu.evaluate(with: self) == true)){
            return true
        }else{
            return false
        }
    }
    /** 匹配身份证号码是否合法*/
    func checkIdentity() -> Bool {
        let regex2 = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        let identityCardPredicate = NSPredicate(format: "SELF MATCHES %@",regex2)
        return identityCardPredicate.evaluate(with: self)
    }
    /** 匹配价格合法  1111.11 */
    func checkMoney() -> Bool {
        let regex2 = "(\\+|\\-)?(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,8}(([.]\\d{0,2})?)))?"
        let identityCardPredicate = NSPredicate(format: "SELF MATCHES %@",regex2)
        return identityCardPredicate.evaluate(with: self)
    }

    /** 匹配价格合法  1111.11 */
    func checkMoney1() -> Bool {
        let regex2 = "(\\+|\\-)?(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,12}(([.]\\d{0,2})?)))?"
        let identityCardPredicate = NSPredicate(format: "SELF MATCHES %@",regex2)
        return identityCardPredicate.evaluate(with: self)
    }



    /** 匹配用户密码是否合法，6-18位数字和字母组合,只能输入由数字和26个英文字母组成的字符串*/
    func checkPassword() -> Bool {
        let regex = "^[a-zA-Z0-9]\\w{5,17}$"
        let identityCardPredicate = NSPredicate(format: "SELF MATCHES %@",regex)
        return identityCardPredicate.evaluate(with: self)
    }
    
    /** 获取一个NSMutableAttributedString*/
    func getAMutableAttributedStringWithAllString(specialSting: String, attributesDictionary: [String : AnyObject]?) -> NSMutableAttributedString {
        let allStr = self
        let specialStr = specialSting
        let mutableAttr = NSMutableAttributedString(string: allStr)
        let nsstr = NSString(string: allStr)
        let theRange = nsstr.range(of: specialStr)
        if theRange.length > 0 {
            mutableAttr.setAttributes(attributesDictionary, range: theRange)
            return mutableAttr
        }else {
            return mutableAttr
        }
    }
    /** 将一个 123456879456 的字符串变为 5.24万，60.58亿*/
    func getLitterNumberWithString() ->String {
        
        if let number = Double(self) {
            if number > 0 && number <= 9999 {/**< 小于一万 >*/
                return self
            }else if number > 9999 && number <= 99999999 {/**< 一万 to 千万 >*/
                let number2 = number / 10000.00
                return String(format:"%.2f万", number2)
            }else if number > 99999999 {/**< 亿 >*/
                let number2 = number / 100000000.00
                return String(format:"%.2f亿", number2)
            }else {
                return self
            }
        }
        return ""
    }

    /** 将一个 123456879456 的字符串变为 123,456,879,456*/
    func getSepString() ->String {
        var tepmStr = self
        if tepmStr.characters.count > 0 {
            let count = (tepmStr.characters.count - 1)/3
            for i in 0..<count {
                let index = tepmStr.index(tepmStr.endIndex, offsetBy: 1-(1+i)*4)
                tepmStr.insert(",", at: index)
            }
        }
        return tepmStr
    }


    //加密
    func signCodePassword() ->String {
        let codee: UInt32 = 956132157
        let aaa = self
        var pass = ""
        for ii in aaa.unicodeScalars {
            let uncode = ii.value
            let tempunicode = uncode^codee
            pass += "\(tempunicode)"
        }
        return pass
    }







    /**< NSUserDefaults 存 >*/
    func userDefaultsForSaveWith(obj: String?) {
        UserDefaults.standard.set(obj, forKey: self)

    }

    func localString() -> String {
        return Bundle.main.localizedString(forKey: self, value: nil, table: nil)
    }


    
}


