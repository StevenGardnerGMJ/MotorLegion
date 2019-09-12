//
//  MyUserInfomaVC.swift
//  MotorLegion
//
//  Created by gemaojing on 16/9/18.
//  Copyright © 2016年 葛茂菁. All rights reserved.
//

import UIKit
import MessageUI

class MyUserInfomaVC: UIViewController,UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate {

    var table_myuser = UITableView()
    let headV_H:CGFloat = 130
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        table_myuser.frame = CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H-44)
        table_myuser.delegate = self
        table_myuser.dataSource = self
        table_myuser.register(UITableViewCell.self, forCellReuseIdentifier: "myuserinformation")
        view.addSubview(table_myuser)
        
        

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITableViewDataSource,UITableViewDelegate
    //TODO: - TODO:TODO:TODO:TODO
    //FIXME: - FIXME:FIXME:FIXME:FIXME:
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headview:UIView = headView()
        headview.frame = CGRect(x: 0, y: 0, width: SCREEN_W, height: headV_H)
        if section == 0 {
            return headview
        }
        return nil
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "myuserinformation", for: indexPath) as UITableViewCell
        
      //  cell.textLabel?.text = "myuserinformation\(indexPath.section)"
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "清除缓存"
        case 1:
            cell.textLabel?.text = "去AppStore 好评"
        case 2:
            cell.textLabel?.text = "意见反馈"
        case 3:
            cell.textLabel?.text = "获取版本号"
        case 4:
            cell.textLabel?.text = "收藏功能"
        case 5:
            cell.textLabel?.text = "法律说明"
        case 6:
            cell.textLabel?.text = "APP使用说明"
        case 7:
            cell.textLabel?.text = "重温酷炫引导页"
        case 8:
            cell.textLabel?.text = "商务合作联系方式"
        case 9 :
            cell.textLabel?.text = "其他"
        default:
            cell.textLabel?.text = "myuserinformation\(indexPath.section+1)"
        }
        
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return headV_H
        }
        
        return 10
    }
    
    // 去掉UItableview headerview黏性(sticky)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        if scrollView == table_myuser {
            let sectionHeaderH:CGFloat = 10
            if (scrollView.contentOffset.y <= sectionHeaderH) && (scrollView.contentOffset.y >= 0) {
                table_myuser.frame = CGRect(x: 0, y: 64, width: SCREEN_W, height: SCREEN_H-64-44)
                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)
                
            } else if scrollView.contentOffset.y >= sectionHeaderH {
                table_myuser.frame = CGRect(x: 0, y: 64, width: SCREEN_W, height: SCREEN_H-64-44)
                scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderH, 0, 0, 0)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            // 去AppStore 好评
            go_AppStoreFeedBack()
        }
        if indexPath.section == 2 {
            print("意见反馈")
            if MFMailComposeViewController.canSendMail() {
                let mailVC = mailFeedBack()
                self.present(mailVC, animated: true, completion: nil)
            } else {
                showSendMailErrorAlert()//无邮箱账户容错处理
            }
        }
        if  indexPath.section == 3 {
            // 获取版本号
            getAPPversion()
        }
        
    }
    
    // ①清除缓存
    // ②评分->跳到AppStore
    // ③获取版本号 bundle version
    // ④意见反馈
    // ⑤收藏功能-> coredata
    
    /*①清除缓存*/
    func  clearCache(){
        // cache 文件路径
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory,FileManager.SearchPathDomainMask.userDomainMask, true).first
        print("路径是：\(cachePath)")
        // 取出文件数组
        let files = FileManager.default.subpaths(atPath: cachePath!)
        // 统计文件内所有文件大小
        var big_how = Int()
        for pa in files! {
            //
            let path = cachePath?.appendingFormat("/\(pa)")  //appendingFormat("/\(pa)", CVarArg.self as! CVarArg)
            let floder = try! FileManager.default.attributesOfItem(atPath: path!)
            for (abc,bcd) in floder {
                // 用元组取出文件属性
                if abc == FileAttributeKey.size {
                    big_how += (bcd as AnyObject).integerValue
                }
            }
        }
      // 提示框
        let messageA = "\(big_how/(1024*1024))M缓存"
        let alert = UIAlertController(title: "清楚缓存", message: messageA, preferredStyle: UIAlertControllerStyle.alert)
        let alerConfirm = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (alerConfirm) in
            for pp in files! {
                let path = cachePath?.appendingFormat("/\(pp)")
                // 判断是否可以删除
                if(FileManager.default.fileExists(atPath: path!)) {
                    // 删除
                    try! FileManager.default.removeItem(atPath: path!)
                }
            }
        }
        
        alert.addAction(alerConfirm)
        let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (cancel) in
            
        }
        alert.addAction(cancel)
        // 提示出弹出框
        present(alert, animated: true, completion: nil)
        
     }
    
    
   /* ②评分->跳到AppStore */
    func go_AppStoreFeedBack() {
        let alertCon = UIAlertController(title: "陛下给个好评吧", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let ok_Action = UIAlertAction(title: "准了", style: UIAlertActionStyle.default) { (ok_Action) in
            self.gotoAppStore()
        }
        let cancel = UIAlertAction(title: "退下", style: .cancel, handler: nil)
        alertCon.addAction(ok_Action)
        alertCon.addAction(cancel)
        self.present(alertCon, animated: true, completion: nil)
        
    }
    // 此功能仅在手机上可行
    func  gotoAppStore(){
        let  urlString = "https://itunes.apple.com/cn/app/yang-che-zhi-jia-qi-che-zhi/id898126444?mt=8"
        // https://itunes.apple.com/cn/app/yang-che-zhi-jia-qi-che-zhi/id898126444?mt=8
        let url_appstore = NSURL(string: urlString)
        UIApplication.shared.openURL(url_appstore as! URL)
        
    }
    
    
    /* ③获取版本号 bundle version */
    // CFBundleVersion，标识（发布或未发布）的内部版本号
    // CFBundleShortVersionString  标识应用程序的发布版本号
    func getAPPversion() {
        // 获取当前版本号 没有就置空（此为用户看到的版本号）
        let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? ""
        // 获取历史版本号：沙盒中存储的版本号
       let sandBoxVersion = UserDefaults.standard.object(forKey: "CFBundleVersion") as? String ?? ""
        // 内部版本号
        let versionBuild = Bundle.main.infoDictionary!["CFBundleVersion"] as? String ?? ""
        
       let altetCon = UIAlertController(title: "currentVersion:\(currentVersion)", message: "CFBundleVersion:\(versionBuild)", preferredStyle: .alert)
       let  cancel = UIAlertAction(title: "退下", style: UIAlertActionStyle.cancel, handler: nil)
       altetCon.addAction(cancel)
       self.present(altetCon, animated: true, completion: nil)
        
        if currentVersion.compare(sandBoxVersion) == ComparisonResult.orderedDescending {
            
            print("通知有新的版本")
            
        } else {
            print("已经是最新版本")
        }
    }
    
    /* ④意见反馈 */
    // 调用邮箱
    func mailFeedBack() -> MFMailComposeViewController{
       
        
        // 获取设备名称
        let deviceName = UIDevice.current.name
        // 获取系统版本号
        let systemVersion = UIDevice.current.systemVersion
        // 获取设备的型号
        let modelName = UIDevice.current.modelName
        // 获取设备唯一标识符
//        let deviceUUID = UIDevice.current.identifierForVendor?.uuidString

        
        // 调用
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["< studychenai@126.com >"])
        mailComposeVC.setSubject("邮件主题:建议与意见")
        mailComposeVC.setMessageBody("反馈的内容:\n\n\n\n\n 设备名称:\(deviceName)\n 系统版本：\(systemVersion)\n 设备型号：\(modelName)", isHTML: false)
        return mailComposeVC
    }
    // 对邮箱容错处理
    func showSendMailErrorAlert(){
        let mailErrorAlert = UIAlertController(title: "无法发送", message: "陛下您的手机邮箱没有设置账户", preferredStyle: UIAlertControllerStyle.alert)
        mailErrorAlert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: { _ in }))
        self.present(mailErrorAlert, animated: true, completion: nil)
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue {
        case MFMailComposeResult.sent.rawValue:
            print("发送成功")
        case MFMailComposeResult.cancelled.rawValue:
            print("发送失败")
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    /* ⑤收藏功能 */
    func collection() {
        // 1,针对图片数据存储, 2,针对string型数据(数据1,2)
        // 3,主要针对URL类型地址：然进行网络请求,获取数据model列表展示
        
    }
    
    // 头部控件 
    func headView()->UIView {
        
        let headBtn = UIButton()
        let nameBtn = UIButton()
        let honourA = UIButton()
        let honourB = UIButton()
        let honourC = UIButton()
        let honourD = UIButton()
        
        let headView = UIView()
        headView.backgroundColor = UIColor.white
        
        
        headBtn.frame = CGRect(x: 10, y: 10, width: 80, height: 80)
        headBtn.layer.borderColor = UIColor.white.cgColor
        headBtn.layer.borderWidth = 2
        headBtn.layer.cornerRadius = 40
        headBtn.backgroundColor = UIColor.yellow
        headBtn.layer.masksToBounds = true
        headBtn.setImage(UIImage(named: "userheader"), for: UIControlState.normal)
        headView.addSubview(headBtn)
        
        nameBtn.frame = CGRect(x: 100, y: 25, width: 100, height: 25)
        nameBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        nameBtn.setTitle("金三胖同志", for: UIControlState.normal)
        nameBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        headView.addSubview(nameBtn)
        
        honourA.frame = CGRect(x: 100, y: 70, width: 30, height: 30)
        honourA.layer.borderColor = UIColor.white.cgColor
        honourA.layer.borderWidth = 2
        honourA.layer.cornerRadius = 15
        honourA.layer.masksToBounds = true
        honourA.setImage(UIImage.init(named: "xunzhangA"), for: UIControlState.normal)
        
        
        honourB.frame = CGRect(x: 140, y: 70, width: 30, height: 30)
        honourB.layer.borderColor = UIColor.white.cgColor
        honourB.layer.borderWidth = 2
        honourB.layer.cornerRadius = 15
        honourB.layer.masksToBounds = true
        honourB.setImage(UIImage.init(named: "xunzhangB"), for: UIControlState.normal)
        
        
//        let point = CGPoint(x: 30, y: 40)
//        
//        let rect = CGRect(x: 10, y: 10, width: 100, height: 40)
        
        honourC.frame = CGRect(x: honourB.frame.maxX+10, y: 70, width: 30, height: 30)
        honourC.layer.borderColor = UIColor.white.cgColor
        honourC.layer.borderWidth = 2
        honourC.layer.cornerRadius = 15
        honourC.layer.masksToBounds = true
        honourC.setImage(UIImage.init(named: "xunzhangC"), for: UIControlState.normal)
        
        honourD.frame = CGRect(x: honourC.frame.maxX + 10 , y: 70, width: 30, height: 30)
        honourD.layer.borderColor = UIColor.white.cgColor
        honourD.layer.borderWidth = 2
        honourD.layer.cornerRadius = 15
        honourD.layer.masksToBounds = true
        honourD.setImage(UIImage.init(named: "xunzhangD"), for: UIControlState.normal)
        
        headView.addSubview(honourA)
        headView.addSubview(honourB)
        headView.addSubview(honourC)
        headView.addSubview(honourD)
        
        
        let bottomV = UIView()
        bottomV.frame = CGRect(x: 0, y: headV_H-10, width: SCREEN_W, height: 10)
        bottomV.backgroundColor = UIColor.init(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1)
        headView.addSubview(bottomV)
        
        
        
        return headView
        
        }
    
}




