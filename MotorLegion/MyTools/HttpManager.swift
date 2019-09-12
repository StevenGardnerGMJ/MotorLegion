//
//  HttpManager.swift
//  MotorLegion
//
//  Created by gemaojing on 2017/11/22.
//  Copyright © 2017年 葛茂菁. All rights reserved.
//

import UIKit

struct HttpManager {
    func finishAllRequest() {
        URLSession.shared.invalidateAndCancel()// 不在需要此会话调用取消
        URLSession.shared.finishTasksAndInvalidate()// 允许任务完成之前无效的对象
    }
    func post(url:String, parameters:[String:Any]?, completionHandler:@escaping(_ obj:AnyObject?) -> Void) {
        let urlString = String(format: "%@/%@/", httpHead,url)
        let session = URLSession.shared
        guard let urls = URL(string: urlString) else {
         completionHandler(nil)
         return
        }
        var request = URLRequest(url: urls)
        request.httpMethod = "POST"
        
        DispatchQueue.global().async {
            
            if let parameters = parameters {
                let bodyString = self.dictToString(dict: parameters)
                request.httpBody = bodyString.data(using: .utf8)
            }
            
            let dataTask = session.dataTask(with: request, completionHandler: { (data, respond, error) in
                DispatchQueue.main.async {
                    // 主线程
                    if let error = error {
                        if error.localizedDescription.contains("未能连接到服务器") || error.localizedDescription.contains("Could not connect to the server") {
                            
                        }
                    }
                }
            })
            
            
        }
        
    }
    
}


extension HttpManager {
    // 字典转字符串
    fileprivate func dictToString(dict: [String: Any]) -> String{
        var string = ""
        for i in dict {
            let tempStr = "\(i.key)=\(i.value)"
            if string.characters.count > 0 {
                string = "\(string)&\(tempStr)"
            }else {
                string = tempStr
            }
        }
        return string
    }
    fileprivate func createBodyWithParameters(parameters: [String : Any]?, filePathKey: String, imageDataKey:Data, boundary: String) -> Data {
        
        var body = Data()
        
        if let parameters = parameters {
            for(key, value) in parameters {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        let fileName = "image.png"
        let mimeType = "image/jpg"
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(fileName)\"\r\n")
        body.appendString(string: "Content-Type: \(mimeType)\r\n\r\n")
        body.append(imageDataKey)
        body.appendString(string: "\r\n")
        body.appendString(string: "--\(boundary)--\r\n")
        return body
    }
    
    fileprivate func generateBoundaryString() -> String{
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    
}



extension Data {
    mutating func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        if let data = data {
            append(data)
        }
    }
}















